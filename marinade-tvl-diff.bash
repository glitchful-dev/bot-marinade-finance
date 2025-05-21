#!/bin/bash

set -e

DATE_CMD="date"
if [[ "$(uname)" == "Darwin" ]]; then
    DATE_CMD="gdate"
fi

function tvl {
    curl -sfLS -X GET "https://api.marinade.finance/tlv?time=$1" | jq '.total_virtual_staked_sol + .marinade_native_stake_sol + .marinade_select_stake_sol | round'
}

PERIOD="$1" # "e.g. 1 week, 30 days, 1 year"

if [[ -z $PERIOD ]]; then
    echo "Usage: $0 <period>" >&2
    echo "  - period format: e.g. '1 day', '4 weeks' etc" >&2
    exit 1
fi

ISO_FMT="%Y-%m-%dT%H:%M:%SZ"
TIME_THEN=$($DATE_CMD -d "$PERIOD ago" -u "+$ISO_FMT" || exit 1)
TIME_NOW=$($DATE_CMD -u "+$ISO_FMT" || exit 1)

TVL_THEN=$(tvl "$TIME_THEN" || exit 1)
TVL_NOW=$(tvl "$TIME_NOW" || exit 1)

echo $(( TVL_NOW - TVL_THEN ))
