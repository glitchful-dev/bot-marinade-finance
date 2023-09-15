function human_readable {
    local num="$1"
    if (( num < 1000 )); then
        echo $(( num / 1))
    elif (( num < 1000000 )); then
        echo $(( num / 1000 ))K
    else
        echo $(( num / 1000000 ))M
    fi
}
