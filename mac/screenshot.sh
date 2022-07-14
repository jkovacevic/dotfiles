#!/bin/bash
find_name() {
    n=$(ls -rt /tmp | grep img | tail -n 1 | sed -e s/img// -e s/\.png//)
    n=$((n+1))
    IMAGE_NAME="/tmp/img$n.png"
}

find_name
screencapture -i $IMAGE_NAME
echo -n $IMAGE_NAME | pbcopy;
osascript -e 'display notification "Created screenshot: '$IMAGE_NAME'"'