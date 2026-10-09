#!/bin/bash


find . -type f -exec md5sum {} + 2>/dev/null | sort > /tmp/all_hashes.txt

uniq -w 32 -d /tmp/all_hashes.txt > /tmp/dup_hashes.txt

if [ ! -s /tmp/dup_hashes.txt ]; then
	echo -e "\033[31mCan't find duplicates\033[0m"
	rm -f /tmp/all_hashes.txt /tmp/dup_hashes.txt
	exit 0
fi

echo

while read -r hash filename; do
	count=$(grep -c "^$hash" /tmp/all_hashes.txt)

	echo "Number of duplicates: $count"
	grep "^$hash" /tmp/all_hashes.txt | awk '{print $2}'
	echo "---"
done < /tmp/dup_hashes.txt

rm -f /tmp/all_hashes.txt

