#!/bin/bash

cb="$(xsel -b | tr '' '\n')"

dest=$(echo "$cb" | cut -c8-)


vi "$dest"
