#!/usr/bin/env perl
use NewPerl;
use English;

foreach my $dir (split(/:/, $ENV{'PATH'})) {
    if (opendir(DIR, $dir)) {
        grep {!/^\./ && print "$_\n" } readdir(DIR);
        closedir DIR;
    } else {
        warn "Can't open dir $dir: $OS_ERROR\n"; } }
