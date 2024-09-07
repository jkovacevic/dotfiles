#!/bin/bash

kill -INT $(pgrep -f "ffmpeg -f x11grab")
kill -INT $(pgrep -f "arecord")
kill -INT $(ps aux | grep queslar_dungeon | grep -v grep | awk '{print $2}')