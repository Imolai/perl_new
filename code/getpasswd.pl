#!/usr/bin/env perl
use CurrentPerl;
use Term::ReadPassword qw(read_password);

print 'Username: ';
my $user = <STDIN>;
chomp $user;

my $passwd = read_password("Password: ");

say "User: $user; Password: $passwd";
