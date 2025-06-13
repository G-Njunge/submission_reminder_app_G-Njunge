Write a shell script named create_environment.sh That sets up the directory structure for an application called submission_reminder_app. This script creates the necessary directories and files for a program that shows students who need to be reminded of their pending submissions. The application's source code will be provided as part of the assignment.

Implement the startup.sh Script:
One part of this assignment is for you to create your startup.sh script.
This script should contain logic that starts up the reminder app when executed.
Make the script executable

Write a shell script named copilot_shell_script.sh that:

Prompts the user to enter the assignment name, then the new input will replace the current name in config/config.env on the ASSIGNMENT value (row 2)
With the sed Or other suitable commands, the input of the assignment can replace the value in config/config.env
When the replacement is complete, you can rerun startup.sh that will check the non-submission status of students for the new assignment that was saved in the config/config.env
