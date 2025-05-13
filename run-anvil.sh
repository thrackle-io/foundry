#!/bin/sh

anvil --host 0.0.0.0 --chain-id "$CHAIN_ID" --dump-state altbc-tungsten-anvil.json &
ANVIL_PID=$!

wait $ANVIL_PID
