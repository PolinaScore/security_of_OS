#!/bin/bash

VERBOSE=0
OUTPUT_FILE=""

show_help() {
	echo -e "\033[1m\033[38;5;201m---HELP---\033[0m"
	echo -e "\033[4mUsage\033[0m: $0 [-h][-v][-o <file>] <operation> <numbers...>"
	echo
	echo -e "\033[4mOptions:\033[0m"
	echo "	-h		Show help"
	echo "	-v		Detailed output"
	echo "	-o <file>	Output the result into a file"
	echo -e "\033[4mOperations:\033[0m"
	echo "	add		Addition"
	echo "	mul		Multiplication"
	echo "	sub		Substitution"
	echo "	pow		Raising to a power"
	echo
	echo -e "\033[4mExamples:\033[0m"
	echo "  $0 add 5 10 15"
    	echo "  $0 -v mul 2 3 4"
    	echo "  $0 -o result.txt sub 100 20 30"
}


while getopts "hvo:" opt; do
 	case $opt in
        	h)
            		show_help
            		exit 0
            	;;
        	v)
            		VERBOSE=1
            	;;
        	o)
            		OUTPUT_FILE="$OPTARG"
            	;;
        	\?)
            		echo -e "\033[31mWrong option: -$OPTARG\033[0m" >&2
            		show_help
            		exit 1
            	;;
    	esac
done


shift $((OPTIND - 1))


if [ $# -lt 2 ]; then
    	echo -e "\033[31mLack of arguments\033[0m" >&2
    	show_help
    	exit 1
fi


OPERATION="$1"
shift
NUMBERS=("$@")



calculate() {
    	local op="$1"
    	shift
    	local nums=("$@")
    	local result="${nums[0]}"

    	for ((i=1; i<${#nums[@]}; i++)); do
        	case "$op" in
            		add)
                		result=$((result + nums[i]))
                	;;
            		mul)
                		result=$((result * nums[i]))
                	;;
            		sub)
                		result=$((result - nums[i]))
                	;;
            		div)
                		if [ "${nums[i]}" -eq 0 ]; then
                    			echo -e "\033[31mZero division error\033[0m" >&2
                    			exit 1
                		fi
                		result=$((result / nums[i]))
                	;;
            		pow)
                		result=$((result ** nums[i]))
                	;;
            		*)
                		echo "Unknown operation: $op" >&2
                		exit 1
                	;;
        	esac
    	done

    	echo "$result"
}




RESULT=$(calculate "$OPERATION" "${NUMBERS[@]}")

if [ $VERBOSE -eq 1 ]; then
    	OUTPUT="Operation: $OPERATION\nNumbers: ${NUMBERS[*]}\nResult: $RESULT"
else
    	OUTPUT="$RESULT"
fi


if [ -n "$OUTPUT_FILE" ]; then
    	echo -e "$OUTPUT" > "$OUTPUT_FILE"
    	echo "Результат сохранён в файл: $OUTPUT_FILE"
else
    	echo -e "$OUTPUT"
fi
