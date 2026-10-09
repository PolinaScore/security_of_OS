#!/bin/bash

TOTAL_SIZE=0
TOTAL_LINES=0
FILE_COUNT=0

echo -e "\t\033[38;5;205mTask .txt extension\033[0m\n"

echo

while IFS= read -r file; do
	echo "$file"
	size=$(stat -c %s "$file" 2>/dev/null)
	lines=$(wc -l < "$file" 2>/dev/null)
	TOTAL_SIZE=$((TOTAL_SIZE + size))
	TOTAL_LINES=$((TOTAL_LINES + lines))
	FILE_COUNT=$((FILE_COUNT + 1))
done < <(find ~ -type f -name "*.txt" 2>/dev/null)

echo
echo -e "\033[4mRESULTS\033[0m"
echo "Number of files: $FILE_COUNT"
echo "Size: $TOTAL_SIZE"
echo "Total number of lines: $TOTAL_LINES"
