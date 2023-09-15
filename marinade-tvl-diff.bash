#!/bin/bash

set -o errexit

function tvl {
    curl -sfLS -X GET "https://api.marinade.finance/tlv?time=$1" | jq '.staked_sol + .marinade_native_stake_sol | round'
}

PERIOD="$1" # "e.g. 1 week, 30 days, 1 year"

if [[ -z $PERIOD ]]; then
    echo "Usage: $0 <period>" >&2
    echo "  - period format: e.g. '1 day', '4 weeks' etc" >&2
    exit 1
fi

ISO_FMT="%Y-%m-%dT%H:%M:%SZ"
TIME_THEN=$(gdate -d "$PERIOD ago" -u "+$ISO_FMT")
TIME_NOW=$(gdate -u "+$ISO_FMT")

TVL_THEN=$(tvl "$TIME_THEN")
TVL_NOW=$(tvl "$TIME_NOW")

echo $(( TVL_NOW - TVL_THEN ))
