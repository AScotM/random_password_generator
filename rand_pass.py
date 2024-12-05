import string
import secrets

def generate_random_password(length):
    characters = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(secrets.choice(characters) for i in range(length))
    return password

random_password = generate_random_password(12)
print("Randomly generated password:", random_password)
