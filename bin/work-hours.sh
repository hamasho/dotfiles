#!/bin/zsh -i

BIN="$0"

usage() {
    echo "${BIN} [-ch]"
    echo "options:"
    echo "  -c: CSV output"
    echo "  -h: Show this help"
}

FORMAT=human

while getopts ch opt; do
    case $opt in
        c) FORMAT=csv;;
        h) usage; exit;;
        *) usage; exit 1;;
    esac
done

MONTH=$(date '+%Y-%m')
COMMAND_TS=$(fc -li 30 | grep -o '\w\w\w\w-\w\w-\w\w \w\w:\w\w' | grep $MONTH)

current_date=
start_ts=
end_ts=
loop_count=0
total_mins=0
total_days=0

print_line() {
    local day="$1" first="$2" last="$3" lunch="$4" duration="$5"
    if [[ "$FORMAT" == human ]]; then
        echo "$day: $first ~ $last ($lunch), total: $duration"
    else  # $FORMAT == csv
        echo $first,$last,$lunch,$duration
    fi
}

print_summary() {
    local days=$1 hours=$2
    [[ "$FORMAT" == csv ]] && return
    echo
    echo "TOTAL: ${hours} hours, ${days} days"
}

for day in $(seq 1 31); do
    [[ ${#day} -eq 1 ]] && day="0${day}"
    com=$(echo $COMMAND_TS | grep $(date '+%Y-%m')-$day)
    if [[ -z "$com" ]]; then
        [[ "$FORMAT" == csv ]] && echo "" || :
        continue
    fi

    first=$(echo $com | head -1 | grep -o "\w\w:\w\w")
    last=$(echo $com | tail -1 | grep -o "\w\w:\w\w")
    duration_sec=$(( `date '+%s' --date=$last` - `date '+%s' --date=$first` ))
    duration_min=$(( duration_sec / 60 ))
    total_mins=$(( total_mins + duration_min ))
    total_days=$(( total_days + 1 ))
    duration_hour=$(( duration_min / 60 ))
    duration_min_part=$(( duration_min % 60 ))
    actual_hour=$(( duration_hour - 1 ))
    [[ ${#actual_hour} -eq 1 ]] && actual_hour="0${actual_hour}"
    [[ ${#duration_min_part} -eq 1 ]] && duration_min_part="0${duration_min_part}"
    lunch="01:00"
    print_line "$day" "$first" "$last" "$lunch" "${actual_hour}:${duration_min_part}"
done

print_summary "$total_days" "$(( $total_mins / 60 ))"
