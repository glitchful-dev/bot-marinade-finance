#!/bin/bash

set -e
curl -sfLS -X GET "https://api.marinade.finance/tlv" | jq '.staked_sol + .marinade_native_stake_sol | round'
