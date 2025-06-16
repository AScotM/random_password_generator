import string
import secrets
import argparse

def generate_random_password(length=12, use_uppercase=True, use_lowercase=True, use_digits=True, use_special=True):
    """
    Generate a secure random password with customizable character sets.
    
    Args:
        length (int): Length of the password (default: 12).
        use_uppercase (bool): Include uppercase letters (default: True).
        use_lowercase (bool): Include lowercase letters (default: True).
        use_digits (bool): Include digits (default: True).
        use_special (bool): Include special characters (default: True).
    
    Returns:
        str: Generated password.
    Raises:
        ValueError: If no character set is selected.
    """
    character_sets = {
        'uppercase': string.ascii_uppercase if use_uppercase else '',
        'lowercase': string.ascii_lowercase if use_lowercase else '',
        'digits': string.digits if use_digits else '',
        'special': string.punctuation if use_special else ''
    }
    
    characters = ''.join(character_sets.values())
    
    if not characters:
        raise ValueError("At least one character set must be selected.")
    
    # Ensure at least one character from each selected set
    password = []
    if use_uppercase:
        password.append(secrets.choice(character_sets['uppercase']))
    if use_lowercase:
        password.append(secrets.choice(character_sets['lowercase']))
    if use_digits:
        password.append(secrets.choice(character_sets['digits']))
    if use_special:
        password.append(secrets.choice(character_sets['special']))
    
    # Fill the rest randomly
    remaining_length = length - len(password)
    password.extend(secrets.choice(characters) for _ in range(remaining_length))
    
    # Shuffle to avoid predictable patterns
    secrets.SystemRandom().shuffle(password)
    
    return ''.join(password)

def main():
    parser = argparse.ArgumentParser(description="Generate a secure random password.")
    parser.add_argument('--length', type=int, default=12, help="Length of the password (default: 12)")
    parser.add_argument('--no-uppercase', action='store_false', dest='use_uppercase', help="Exclude uppercase letters")
    parser.add_argument('--no-lowercase', action='store_false', dest='use_lowercase', help="Exclude lowercase letters")
    parser.add_argument('--no-digits', action='store_false', dest='use_digits', help="Exclude digits")
    parser.add_argument('--no-special', action='store_false', dest='use_special', help="Exclude special characters")
    args = parser.parse_args()
    
    try:
        password = generate_random_password(
            length=args.length,
            use_uppercase=args.use_uppercase,
            use_lowercase=args.use_lowercase,
            use_digits=args.use_digits,
            use_special=args.use_special
        )
        print("Generated Password:", password)
    except ValueError as e:
        print("Error:", e)

if __name__ == "__main__":
    main()
