#!/usr/bin/perl
use strict;
use warnings;
use Term::ReadLine;
use List::Util 'shuffle';

# Function to generate a random password
sub generate_password {
    my ($length, $use_letters, $use_digits, $use_special) = @_;
    
    my $characters = "";
    $characters .= "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" if $use_letters;
    $characters .= "0123456789" if $use_digits;
    $characters .= "!\"\$%&'()*+,-./:;<=>?@[\\]^_`{|}~" if $use_special;

    die "No character sets selected for password generation.\n" unless $characters;

    my @chars = shuffle split //, $characters;
    my $password = join '', @chars[0 .. $length - 1];

    return $password;
}

# Function to check the strength of the generated password
sub is_password_strong {
    my ($password, $use_letters, $use_digits, $use_special) = @_;
    my $has_letters = $use_letters ? ($password =~ /[a-zA-Z]/) : 1;
    my $has_digits  = $use_digits  ? ($password =~ /\d/)       : 1;
    my $has_special = $use_special ? ($password =~ /[^a-zA-Z\d]/) : 1;
    return $has_letters && $has_digits && $has_special;
}

# Function to handle the main menu
sub main_menu {
    print "\n--- Random Password Generator ---\n";
    my $term = Term::ReadLine->new('Password Generator');

    while (1) {
        print "\nChoose an option:\n";
        print "1. Generate password\n";
        print "2. Exit\n";
        print "Enter your choice: ";
        my $choice = $term->readline();

        if ($choice eq "1") {
            password_config();
        } elsif ($choice eq "2") {
            exit_program($term);
        } else {
            print "Invalid choice. Please try again.\n";
        }
    }
}

# Function to handle password configuration
sub password_config {
    my $term = Term::ReadLine->new('Password Config');

    print "Enter password length: ";
    my $length = $term->readline();
    chomp $length;

    unless (is_positive_integer($length)) {
        print "Password length must be a positive integer.\n";
        return;
    }

    my $use_letters = prompt_for_inclusion($term, "Letters");
    my $use_digits = prompt_for_inclusion($term, "Digits");
    my $use_special = prompt_for_inclusion($term, "Special characters");

    unless ($use_letters || $use_digits || $use_special) {
        print "You must include at least one character type!\n";
        return;
    }

    my $password;
    do {
        $password = generate_password($length, $use_letters, $use_digits, $use_special);
    } until (is_password_strong($password, $use_letters, $use_digits, $use_special));

    print "\nGenerated Password: $password\n";
}

# Function to check if a given input is a positive integer
sub is_positive_integer {
    my ($input) = @_;
    return $input =~ /^\d+$/ && $input > 0;
}

# Function to prompt for inclusion of a character set
sub prompt_for_inclusion {
    my ($term, $set_name) = @_;
    print "$set_name (y/n): ";
    return lc($term->readline()) eq 'y';
}

# Function to handle exit confirmation
sub exit_program {
    my ($term) = @_;
    print "Are you sure you want to exit? (y/n): ";
    my $confirm_exit = lc($term->readline());
    if ($confirm_exit eq 'y') {
        print "Exiting. Goodbye!\n";
        exit 0;
    }
}

# Run the program
main_menu();
