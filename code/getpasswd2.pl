#!/usr/bin/env perl
use NewPerl;
use IO::Prompter;
 
my $user = prompt 'Username:';
# Note that you do need Term::ReadKey to be installed for the password masking function to work.
# The module does not warn you about this at build time.
my $passwd = prompt 'Password:', -echo=>'*';

say "User: $user; Password: $passwd";
