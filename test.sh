#!/usr/bin/env bash

if [[ "$(hostname)" = jizo ]]; then
	echo "Entering environment for jizo"
	export PATH="/usr/local/cuda-10.1/bin:$PATH"
fi

stack build
while true; do
	cuda-memcheck stack run || break
done
