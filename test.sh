#!/usr/bin/env bash
stack build
while true; do
	cuda-memcheck stack run || break
done
