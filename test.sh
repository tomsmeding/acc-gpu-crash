#!/usr/bin/env bash
cabal build
while true; do
	cuda-memcheck cabal run || break
done
