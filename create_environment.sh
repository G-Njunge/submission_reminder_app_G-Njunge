#!/bin/bash 

read -p "What is your first name?: " user_name  #prompts the user for their name
dir_name="submission_reminder_${user_name}"
mkdir -p  submission_reminder_$user_name
echo "$user_name, your app environment is created"

sub_dir=("app" "modules" "assets" "config") #lists do not require , 
file_name=("reminder.sh" "functions.sh" "submissions.txt" "config.env")

#I am using for loops for a cleaner and more dynamic code
#since I've got two lists I will use indexes instead of string variable names in my for loop

for i in "${!sub_dir[@]}"  
do
	mkdir -p submission_reminder_$user_name/${sub_dir[$i]}
	script_file=submission_reminder_$user_name/${sub_dir[$i]}/${file_name[$i]}
	touch "$script_file"
	if [[ "$script_file" == *.sh ]]; then
		chmod +x $script_file

	fi

done

cat > "submission_reminder_$user_name/assets/submissions.txt" << EOL
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Dean, Shell Navigation, not submitted
Ati, Git, not submitted
Joy, Shell Basics,not submitted
Lin, Git, submitted
Hope, Shell Navigation, submitted
EOL


cat > "submission_reminder_$user_name/config/config.env" << EOL
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL
cat > "submission_reminder_$user_name/modules/functions.sh" << 'EOL'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOL
cat > "submission_reminder_$user_name/app/reminder.sh" << EOL
#!/bin/bash

resolved_path="\$(readlink -f "\${BASH_SOURCE[0]}")"
echo "Resolved path: \$resolved_path"

script_dir="\$(dirname "\$resolved_path")"
echo "Script directory : \$script_dir" 

#Go up one level to base folder
base_dir="\$(dirname "\$script_dir")"

echo "file \$base_dir"

# Source environment variables and helper functions
source "submission_reminder_$user_name/config/config.env"
source "submission_reminder_$user_name/modules/functions.sh"

# Path to the submissions file
submissions_file="\$base_dir/assets/submissions.txt"
echo "Submissions file : \$submissions_file"

# Print remaining time and run the reminder function
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit:\$DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "\$submissions_file"
EOL

cat > "submission_reminder_$user_name/startup.sh" << EOL
#!/bin/bash
dir_name="$(dirname "$(readlink -f "$0")")"
bash "$dir_name/app/reminder.sh" 
EOL
chmod 755 submission_reminder_$user_name/startup.sh
