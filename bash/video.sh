#!/bin/bash
# Screen recorder: pick a monitor by autodetecting xrandr geometry, record
# video + system audio with ffmpeg, stop gracefully, copy output path to clipboard.

PID_FILE="/tmp/.video-recording.pid"
META_FILE="/tmp/.video-recording.path"
LOG_FILE="/tmp/.video-recording.log"

detect_monitor_geometry() {
    # $1 = left|right. Picks the connected monitor with the smallest (left)
    # or largest (right) X offset, so it keeps working if monitor names/order change.
    local side="$1"
    local geoms
    geoms=$(xrandr --listmonitors | tail -n +2 | grep -oP '\d+/\d+x\d+/\d+\+\d+\+\d+' | sed -E 's#/[0-9]+##g')

    if [ -z "$geoms" ]; then
        return 1
    fi

    if [ "$side" == "left" ]; then
        echo "$geoms" | awk -F'[x+]' '{print $3, $0}' | sort -n | head -n1 | awk '{print $2}'
    else
        echo "$geoms" | awk -F'[x+]' '{print $3, $0}' | sort -n | tail -n1 | awk '{print $2}'
    fi
}

start_recording() {
    local side="$1"

    if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
        notify-send "Screen Recording" "Already recording (PID $(cat "$PID_FILE"))."
        exit 1
    fi

    local geom
    geom=$(detect_monitor_geometry "$side")
    if [ -z "$geom" ]; then
        notify-send "Screen Recording" "Could not detect monitor geometry via xrandr."
        exit 1
    fi

    local width height rest x y
    width=$(cut -d'x' -f1 <<< "$geom")
    rest=$(cut -d'x' -f2 <<< "$geom")
    height=$(cut -d'+' -f1 <<< "$rest")
    x=$(cut -d'+' -f2 <<< "$rest")
    y=$(cut -d'+' -f3 <<< "$rest")

    local monitor_source
    monitor_source="$(pactl get-default-sink).monitor"

    local video_file
    video_file="/tmp/vid-$(date +%Y%m%d_%H%M%S).mp4"

    setsid ffmpeg -y \
        -thread_queue_size 1024 -f x11grab -video_size "${width}x${height}" -framerate 30 -i ":0.0+${x},${y}" \
        -thread_queue_size 1024 -f pulse -i "$monitor_source" \
        -c:v libx264 -preset veryfast -crf 20 -pix_fmt yuv420p \
        -c:a aac -b:a 128k \
        "$video_file" > "$LOG_FILE" 2>&1 < /dev/null &

    local pid=$!
    disown
    echo "$pid" > "$PID_FILE"
    echo "$video_file" > "$META_FILE"

    notify-send "Screen Recording" "Started recording $side monitor (${width}x${height})"
}

stop_recording() {
    if [ ! -f "$PID_FILE" ]; then
        notify-send "Screen Recording" "No recording in progress."
        exit 1
    fi

    local pid video_file
    pid=$(cat "$PID_FILE")
    video_file=$(cat "$META_FILE" 2>/dev/null)

    kill -INT "$pid" 2>/dev/null

    # Give ffmpeg time to finalize the mp4 (write the moov atom) before we touch the file.
    for _ in $(seq 1 50); do
        kill -0 "$pid" 2>/dev/null || break
        sleep 0.2
    done

    rm -f "$PID_FILE" "$META_FILE"

    if [ -n "$video_file" ] && [ -f "$video_file" ]; then
        echo -n "$video_file" | xclip -selection clipboard
        notify-send "Screen Recording" "Saved: $video_file (path copied to clipboard)"
    else
        notify-send "Screen Recording" "Recording stopped but output file was not found."
    fi
}

case "$1" in
    start)
        case "$2" in
            left|right) start_recording "$2" ;;
            *) notify-send "Screen Recording" "Usage: video.sh start left|right"; exit 1 ;;
        esac
        ;;
    stop)
        stop_recording
        ;;
    *)
        echo "Usage: $0 start left|right | stop"
        exit 1
        ;;
esac
