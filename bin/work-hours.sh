#!/bin/zsh -i

BIN="$0"

usage() {
    echo "${BIN} [-ch]"
    echo "options:"
    echo "  -c: CSV output"
    echo "  -m MONTH: Month"
    echo "  -l: Only print git commit log for each working day"
    echo "  -h: Show this help"
}

FORMAT=human
PRINT_COMMIT_LOG=false
MONTH=$(date +%m)

while getopts clm:h opt; do
    case $opt in
        c) FORMAT=csv;;
        l) PRINT_COMMIT_LOG=true;;
        h) usage; exit;;
        m) MONTH=$(printf "%02d" $OPTARG);;
        *) usage; exit 1;;
    esac
done

TARGET_MONTH=$(date +%Y)-${MONTH}
ALL_COMMANDS=$(fc -li 1 | sed 's/^ *[0-9]* *//' | grep "^$TARGET_MONTH")

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

count_remaining_weekdays() {
    local today=$(date +%d) total=0 day next_month=$(( MONTH + 1 ))
    last_day=$(date +%d -d "$(date +%Y-$next_month-01) -1 day")
    for day in $(seq $(( today + 1 )) $last_day); do
        week=$(date +%a -d "2019-${MONTH}-${day}")
        if [ $week != Sun ] && [ $week != Sat ]; then
            total=$(( total + 1 ))
        fi
    done
    echo $total
}

min_to_time() {
    local min=$1
    hour=$(( min / 60 ))
    min=$(( min % 60 ))
    echo -n "$(printf '%02d' $hour):$(printf '%02d' $min)"
}

echo
for day in $(seq 1 31); do
    day=$(printf "%02d" day)
    com=$(echo $ALL_COMMANDS | grep "^${TARGET_MONTH}-$day")

    if [[ $PRINT_COMMIT_LOG == true ]]; then
        if [[ -n "$com" ]]; then
            echo DAY: $day
            echo $com | egrep '(gcam|gc -m)'
            echo
        fi
        continue
    fi

    if [[ -z "$com" ]]; then
        if [[ "$FORMAT" == csv ]]; then
            echo "00:00,00:00,00:00,00:00"
        else
            echo "$day:"
        fi
        continue
    fi

    first=$(echo $com | head -1 | grep -o "\w\w:\w\w")
    last=$(echo $com | tail -1 | grep -o "\w\w:\w\w")
    duration_sec=$(( `date '+%s' --date=$last` - `date '+%s' --date=$first` ))
    duration_min=$(( duration_sec / 60 ))

    if (( duration_min > 360 )); then
        lunch_min=60
    elif (( duration_min > 180 )); then
        lunch_min=30
    else
        lunch_min=0
    fi

    day_total_mins=$(( duration_min - lunch_min ))
    total_mins=$(( total_mins + day_total_mins ))
    total_days=$(( total_days + 1 ))

    duration_hour=$(( duration_min / 60 ))
    print_line "$day" "$first" "$last" "$(min_to_time $lunch_min)" "$(min_to_time $day_total_mins)"
done

if [[ $FORMAT == human ]]; then
    total_hours=$(( $total_mins / 60 ))
    print_summary "$total_days" $total_hours

    remain_days=$(count_remaining_weekdays) 
    if [[ $remain_days != 0 ]]; then
        echo REMAIN: $remain_days days, \
            min: $(( (140 - total_hours) / remain_days + 1 )) hours/day +1 hour lunch, \
            avg: $(( (160 - total_hours) / remain_days + 1 )) hours/day +1 hour lunch
    fi

    echo

    cal
fi
