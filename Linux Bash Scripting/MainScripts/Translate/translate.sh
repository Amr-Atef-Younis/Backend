#!/bin/bash

x=$(xclip -o)

/usr/share/iron/chrome-wrapper "http://www.google.com/search?q=$x meaning" &
