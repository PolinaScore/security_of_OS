#!/bin/bash

if [ $# -eq 0 ]; then
	echo -e "\033[31mInput CSV-file\033[0m" >&2
	echo -e "\033[4mUsage:\033[0m $0 <file.csv>" >&2;
	exit 1
fi

CSV_FILE="$1"

if [ ! -f "$CSV_FILE" ]; then
	echo -e "\033[31mCan't find '$CSV_FILE'\033[0m" >&2
	exit 1
fi

RESULT=$(awk -F',' 'NR>1 {
    	sum += $3
    	count++
    	if ($3 > max) max = $3
}
END {
    	avg = (count > 0) ? sum / count : 0
    	printf "Общая сумма продаж: %.2f\n", sum
    	printf "Средняя стоимость продажи: %.2f\n", avg
    	printf "Самая дорогая продажа: %.2f\n", max
}' "$CSV_FILE")


echo "$RESULT" | tee sales_report.txt

