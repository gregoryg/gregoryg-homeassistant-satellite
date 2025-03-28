#! /usr/bin/env bash
thing=$(cat)
# This script should be triggered on the stopping of a timer

echo "$(date)  timer-end: This is the full command: $@" | tee -a /tmp/timer-started.log
echo "                                       and cat: $thing"          | tee -a /tmp/timer-started.log
