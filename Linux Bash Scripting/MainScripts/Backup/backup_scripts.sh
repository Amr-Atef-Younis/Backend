#!/bin/bash
source "${HELPERS_DIRECTORY}Notifications.sh"

# sleep 5m

copy_log_path="${SCRIPTS_DIRECTORY}Backup/copy_log.txt"
	

echo $(date | cut -d ' ' -f-4) >> "$copy_log_path"

echo >> "$copy_log_path"

cp -au ~/.bashrc "${SCRIPTS_DIRECTORY}AllShortcuts/up2date_shorcuts/" &>> "$copy_log_path"

cp -au ~/.bash_aliases "${SCRIPTS_DIRECTORY}AllShortcuts/up2date_shorcuts/" &>> "$copy_log_path"

cp -au ~/.xbindkeysrc "${SCRIPTS_DIRECTORY}AllShortcuts/up2date_shorcuts/" &>> "$copy_log_path"

cp -au ~/kglobalshortcutsrc "${SCRIPTS_DIRECTORY}AllShortcuts/up2date_shorcuts/" &>> "$copy_log_path"

cp -au "${SCRIPTS_DIRECTORY}"* "/mnt/D/OS Programs/Backup/Scripts" &>> "$copy_log_path"

cp -aur "${BOSTA_DIRECTORY}My_Scripts/"* "${SCRIPTS_DIRECTORY}Bosta/" &>> "$copy_log_path"

echo >> "$copy_log_path"
echo >> "$copy_log_path"
echo >> "$copy_log_path"

cd "${SCRIPTS_DIRECTORY}"


git_log_path="${SCRIPTS_DIRECTORY}Backup/git_log.txt"
commit_dest="${SCRIPTS_DIRECTORY}Backup/commit.txt"


echo $(date | cut -d ' ' -f-4) >> "$git_log_path"


git add .
git commit -m "$(date | cut -d ' ' -f-6)" &> "$commit_dest"

echo $(cat $commit_dest | sed -n '2p') &>> "$git_log_path"
echo >> "$git_log_path"


git push origin
git push origin &>> "$git_log_path"

echo >> "$git_log_path"
echo >> "$git_log_path"
echo >> "$git_log_path"

