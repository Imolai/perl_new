#!/usr/bin/env perl
use NewPerl;

my $hosts   = '/etc/hosts';
my $pattern = 'local';
my $fh      = IO::File->new($hosts, 'r');
if (defined $fh) {
    while (my $line = $fh->getline) {
        print $line if $line =~ m/$pattern/; }
    undef $fh; }
