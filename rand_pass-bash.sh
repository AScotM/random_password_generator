#!/bin/bash

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

    # Generate password using /dev/urandom and tr
    PASSWORD=$(tr -dc "$charset" < /dev/urandom | head -c "$length")
    if [[ ${#PASSWORD} -ne $length ]]; then
        echo "Error: Failed to generate a password of the requested length!"
        return 1
    fi

    echo -e "\nGenerated Password: $PASSWORD"
}

# User input section
echo -e "\n--- Random Password Generator ---"

# Get password length
while true; do
    read -rp "Enter password length: " length
    if [[ $length =~ ^[0-9]+$ && $length -gt 0 ]]; then
        break
    else
        echo "Invalid input! Please enter a positive number."
    fi
done

# Ask for character set inclusion
while true; do
    read -rp "Include letters? (y/n): " use_letters
    if [[ $use_letters =~ ^[yYnN]$ ]]; then
        break
    else
        echo "Invalid input! Please enter 'y' or 'n'."
    fi
done

while true; do
    read -rp "Include digits? (y/n): " use_digits
    if [[ $use_digits =~ ^[yYnN]$ ]]; then
        break
    else
        echo "Invalid input! Please enter 'y' or 'n'."
    fi
done

while true; do
    read -rp "Include special characters? (y/n): " use_special
    if [[ $use_special =~ ^[yYnN]$ ]]; then
        break
    else
        echo "Invalid input! Please enter 'y' or 'n'."
    fi
done

# Generate password based on user choices
generate_password "$length" "$use_letters" "$use_digits" "$use_special"
