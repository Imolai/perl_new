#!/usr/bin/env perl
use CurrentPerl;

my $filename = "welcome.pl";
my $fh       = IO::File->new($filename, 'r');
if (defined $fh) {
    my @lines = $fh->getlines;
    undef $fh;
    print @lines;
}
