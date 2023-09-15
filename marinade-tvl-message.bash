#!/bin/bash
set -e

function fmt {
    numfmt --to si --round nearest
}

ARROW_UP=▲
ARROW_DOWN=▼

echo "TVL: $(./marinade-tvl.bash | fmt)"

for PERIOD in "24 hours" "7 days"
do
    TVL_DIFF_VALUE=$(./marinade-tvl-diff.bash "$PERIOD")

    if ((TVL_DIFF_VALUE < 0))
    then
        TVL_DIFF_ARROW=$ARROW_DOWN
    elif ((TVL_DIFF_VALUE > 0))
    then
        TVL_DIFF_ARROW=$ARROW_UP
    else
        TVL_DIFF_ARROW=""
    fi

    echo "$TVL_DIFF_ARROW Last $PERIOD: $(<<<"$TVL_DIFF_VALUE" fmt) SOL"
done
