#! /usr/bin/env bash

thing=$(cat)
# This script should be triggered on the starting of a timer

echo "$(date)  timer-start: This is the full command: $@" | tee -a /tmp/timer-started.log
echo "                                       and cat: $thing"          | tee -a /tmp/timer-started.log
