#!/bin/bash
#Prompts the user to enter the assignment name, 
#then the new input will replace the current name in config/config.env
source create_environment.sh
read -p "Which assignment would you want to check?: " assign

sed -i "2s|.*|ASSIGNMENT=$assign|" submission_reminder_$user_name/config/config.env
