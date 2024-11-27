import random
import string

def generate_password(length, use_letters=True, use_digits=True, use_special=True):
    characters = ""
    if use_letters:
        characters += string.ascii_letters
    if use_digits:
        characters += string.digits
    if use_special:
        characters += string.punctuation

    if not characters:
        raise ValueError("No character sets selected for password generation.")

    return ''.join(random.choice(characters) for _ in range(length))

def tree_menu():
    print("\n--- Random Password Generator ---")
    while True:
        print("\nChoose an option:")
        print("1. Generate password")
        print("2. Exit")
        choice = input("Enter your choice: ").strip()

        if choice == "1":
            password_config()
        elif choice == "2":
            print("Exiting. Goodbye!")
            break
        else:
            print("Invalid choice. Please try again.")

def password_config():
    try:
        length = int(input("Enter password length: ").strip())
        if length <= 0:
            print("Password length must be greater than zero.")
            return

        print("\nInclude the following in your password:")
        use_letters = input("Letters (y/n): ").strip().lower() == 'y'
        use_digits = input("Digits (y/n): ").strip().lower() == 'y'
        use_special = input("Special characters (y/n): ").strip().lower() == 'y'

        if not (use_letters or use_digits or use_special):
            print("You must include at least one character type!")
            return

        password = generate_password(length, use_letters, use_digits, use_special)
        print("\nGenerated Password:", password)

    except ValueError as e:
        print(f"Error: {e}. Please try again.")

if __name__ == "__main__":
    tree_menu()

