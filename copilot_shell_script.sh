#!/bin/bash
source create_environment.sh #since we are using a variable from this file
#prompt the user for input
read -p "Which assignment would you want to check?: " assign
#then the new input will replace the current name in config/config.env
sed -i "2s|.*|ASSIGNMENT=\"$assign\"|" "submission_reminder_$user_name/config/config.env"

#run the startup file 
bash submission_reminder_$user_name/startup.sh
