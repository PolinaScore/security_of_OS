#!/bin/bash


if [ $# -eq 0 ]; then
	echo -e "\033[31mInput CSV-file\033[0m" >&2
      	echo -e "\033[4mUsage:\033[0m $0 [-f] [-g] <file.csv>" >&2;
      	exit 1
fi


CSV_MODE=0
SQL_MODE=0
CSV_FILE=""


while getopts "fg" opt; do
    	case $opt in
        	f) CSV_MODE=1 ;;
        	g) SQL_MODE=1 ;;
        	\?) echo -e "\033[31mWrong option: -$OPTARG\-33[0m" >&2; exit 1 ;;
    	esac
done


shift $((OPTIND - 1))
CSV_FILE="$1"

if [ ! -f "$CSV_FILE" ]; then
    	echo -e "\033[31mCan't find '$CSV_FILE'\033[0m" >&2
       	exit 1
fi


get_stats() {
    	awk -F',' 'NR>1 {
        	sum += $3
        	count++
        	if ($3 > max) max = $3
    	}
    	END {
        	avg = (count > 0) ? sum / count : 0
        	printf "%.2f %.2f %.2f\n", sum, avg, max
    	}' "$CSV_FILE"
}


read SUM AVG MAX < <(get_stats)


if [ $CSV_MODE -eq 0 ] && [ $SQL_MODE -eq 0 ]; then
    	{
        	echo "Общая сумма продаж: $SUM"
        	echo "Средняя стоимость продажи: $AVG"
        	echo "Самая дорогая продажа: $MAX"
    	} | tee sales_report_1.txt
    	echo
    	exit 0
fi

if [ $CSV_MODE -eq 1 ]; then
    	{
        	echo "metric,value"
        	echo "total_sales,$SUM"
        	echo "average_sale,$AVG"
        	echo "max_sale,$MAX"
    	} | tee sales_report_1.csv
    	echo
    	exit 0
fi


if [ $SQL_MODE -eq 1 ]; then
    	{
        	echo "-- SQL-скрипт для импорта данных о продажах в PostgreSQL"
        	echo "-- Сгенерировано: $(date)"
        	echo
        	echo "-- Создание таблицы"
        	echo "CREATE TABLE IF NOT EXISTS sales_stats ("
        	echo "    id SERIAL PRIMARY KEY,"
        	echo "    metric VARCHAR(50) NOT NULL,"
        	echo "    value NUMERIC(12, 2) NOT NULL,"
        	echo "    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
        	echo ");"
        	echo
        	echo "-- Вставка данных"
        	echo "INSERT INTO sales_stats (metric, value) VALUES"
        	echo "    ('total_sales', $SUM),"
        	echo "    ('average_sale', $AVG),"
        	echo "    ('max_sale', $MAX);"
        	echo
        	echo "-- Проверка результата"
        	echo "SELECT * FROM sales_stats ORDER BY id;"
    		} | tee sales_import.sql
    	echo
    	exit 0
fi
