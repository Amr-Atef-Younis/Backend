#!/bin/bash

indices=$(grep -n "From" test.txt | cut -d: -f 1 | tail -n 1)

wordnet_idx=$(grep -n "From WordNet" test.txt | cut -d: -f 1)

last_idxgrep -n "From" test.txt | cut -d: -f 1 | tail -n 1
