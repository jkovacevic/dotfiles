#!/bin/bash

kill $(pgrep -f "ffmpeg -f x11grab")
kill $(pgrep -f "arecord")