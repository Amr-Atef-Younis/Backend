#!/bin/bash

echo -n "[$(xsel -b | awk '{print "\""$0"\""}' | paste -sd, -)]" | xclip -selection c
