#!/bin/zsh -i

MONTH=$(date '+%Y-%m')
COMMAND_TS=$(fc -li 30 | grep -o '\w\w\w\w-\w\w-\w\w \w\w:\w\w' | grep $MONTH)

current_date=
start_ts=
end_ts=
loop_count=0
total_mins=0
total_days=0

for i in $(seq 1 31); do
    [[ ${#i} -eq 1 ]] && i="0${i}"
    com=$(echo $COMMAND_TS | grep $(date '+%Y-%m')-$i)
    if [[ -z "$com" ]]; then
        echo ""
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
    echo $first,$last,01:00,${actual_hour}:${duration_min_part}
done
