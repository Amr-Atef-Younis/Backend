#!/bin/bash

domain=$(zenity --entry --text "Domain")
search=$(zenity --entry --text "Search")

if [[ $domain == "g" ]];
then
xdg-open "http://www.google.com/search?q=$search"
elif [[ $domain == "y" ]];
then
xdg-open "http://www.youtube.com/search?q=$search"
fi
