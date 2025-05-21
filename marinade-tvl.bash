#!/bin/bash

set -e
curl -sfLS -X GET "https://api.marinade.finance/tlv" | jq '.total_virtual_staked_sol + .marinade_native_stake_sol + .marinade_select_stake_sol | round'
