#!/bin/bash

"/opt/Notion/notion-app" & 

rambox &

clementine -v 100 &

muezzin &

sleep 9

"${SCRIPTS_DIRECTORY}Show Hide Applications/minimize.sh" Muezzin &

sleep 8

"${SCRIPTS_DIRECTORY}CloseOpen/closeOpen.sh" rambox &

sleep 3

"${SCRIPTS_DIRECTORY}Show Hide Applications/minimize.sh" Notion &

