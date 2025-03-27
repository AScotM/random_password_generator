#!/bin/bash

# Function to check if required commands are available
check_commands() {
    for cmd in "$@"; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "Error: $cmd is not installed."
            exit 1
        fi
    done
}

# Function to generate a password
generate_password() {
    local length=$1
    local use_letters=$2
    local use_digits=$3
    local use_special=$4
    local charset=""
    
    [[ $use_letters == "y" ]] && charset+="A-Za-z"
    [[ $use_digits == "y" ]] && charset+="0-9"
    [[ $use_special == "y" ]] && charset+="!@#$%^&*()-_=+"
    
    if [[ -z "$charset" ]]; then
        echo "Error: No character sets selected!"
        return 1
    fi

    PASSWORD=$(tr -dc "$charset" < /dev/urandom | head -c "$length")
    if [[ ${#PASSWORD} -ne $length ]]; then
        echo "Error: Failed to generate a password of the requested length!"
        return 1
    fi

    echo -e "\nGenerated Password: $PASSWORD"
}

# Check if required commands are available
check_commands tr head

# User input section
echo -e "\n--- Random Password Generator ---"

# Get password length
while true; do
    read -rp "Enter password length (default 12): " length
    length=${length:-12}
    if [[ $length =~ ^[0-9]+$ && $length -gt 0 && $length -le 128 ]]; then
        break
    else
        echo "Invalid input! Please enter a positive number between 1 and 128."
    fi
done

# Ask for character set inclusion
while true; do
    read -rp "Include letters? (y/n, default y): " use_letters
    use_letters=${use_letters:-y}
    if [[ $use_letters =~ ^[yYnN]$ ]]; then
        break
    else
        echo "Invalid input! Please enter 'y' or 'n'."
    fi
done

while true; do
    read -rp "Include digits? (y/n, default y): " use_digits
    use_digits=${use_digits:-y}
    if [[ $use_digits =~ ^[yYnN]$ ]]; then
        break
    else
        echo "Invalid input! Please enter 'y' or 'n'."
    fi
done

while true; do
    read -rp "Include special characters? (y/n, default y): " use_special
    use_special=${use_special:-y}
    if [[ $use_special =~ ^[yYnN]$ ]]; then
        break
    else
        echo "Invalid input! Please enter 'y' or 'n'."
    fi
done

# Generate password based on user choices
generate_password "$length" "$use_letters" "$use_digits" "$use_special"
