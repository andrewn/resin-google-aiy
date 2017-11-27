#!/bin/bash

echo "Start"
export XDG_CACHE_HOME=/data/
cd /usr/aiyprojects-raspbian-voicekit/
source env/bin/activate
python3 src/assistant_library_demo.py
