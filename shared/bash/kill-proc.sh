#!/bin/bash

kill -INT $(pgrep -f "ffmpeg -f x11grab")
kill -INT $(pgrep -f "arecord")