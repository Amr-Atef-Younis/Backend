#!/bin/bash

"${BOSTA_DIRECTORY}My_Scripts/Connections/JumpServers/JumpServers.sh" &

mongodb-compass &
dbeaver-ce &

source "${HELPERS_DIRECTORY}Functions.sh"

zenityQuestion "Leave applications open?" "3"
sleep 15
bash "${BOSTA_DIRECTORY}My_Scripts/Minimize/minimize.sh" MongoDB &
bash "${BOSTA_DIRECTORY}My_Scripts/Minimize/minimize.sh" dbeaver &
