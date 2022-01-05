#!/usr/bin/env perl
use NewPerl;

my $filename = "welcome.pl";
open my ($f), '<', $filename;
my @lines = <$f>;
close $f;
print @lines;
