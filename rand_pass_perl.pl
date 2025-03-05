#!/usr/bin/perl
use strict;
use warnings;
use Term::ReadLine;
use List::Util 'shuffle';

sub generate_password {
    my ($length, $use_letters, $use_digits, $use_special) = @_;
    
    my $characters = "";
    $characters .= "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" if $use_letters;
    $characters .= "0123456789" if $use_digits;
    $characters .= "!\"\$%&'()*+,-./:;<=>?@[\\]^_`{|}~" if $use_special;

    die "No character sets selected for password generation.\n" unless $characters;

    my @chars = split //, $characters;
    my $password = join '', map { $chars[rand @chars] } 1 .. $length;

    return $password;
}

sub tree_menu {
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
            print "Exiting. Goodbye!\n";
            last;
        } else {
            print "Invalid choice. Please try again.\n";
        }
    }
}

sub password_config {
    my $term = Term::ReadLine->new('Password Config');

    print "Enter password length: ";
    my $length = $term->readline();
    chomp $length;

    if ($length !~ /^\d+$/ || $length <= 0) {
        print "Password length must be greater than zero.\n";
        return;
    }

    print "\nInclude the following in your password:\n";
    print "Letters (y/n): ";
    my $use_letters = lc($term->readline()) eq 'y';

    print "Digits (y/n): ";
    my $use_digits = lc($term->readline()) eq 'y';

    print "Special characters (y/n): ";
    my $use_special = lc($term->readline()) eq 'y';

    unless ($use_letters || $use_digits || $use_special) {
        print "You must include at least one character type!\n";
        return;
    }

    my $password = generate_password($length, $use_letters, $use_digits, $use_special);
    print "\nGenerated Password: $password\n";
}

# Run the program
tree_menu();

