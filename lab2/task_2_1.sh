#!/bin/bash

LOG_FILE="/tmp/run.log"

if [ -f "$LOG_FILE" ]; then
	PREV_RUNS=$(wc -l < "$LOG_FILE")
else
	PREV_RUNS=0
fi

echo -e "\033[38;5;201mNumber of previous runs\033[0m: $PREV_RUNS" >&2

date >> "$LOG_FILE"

echo "Hello, World!"
