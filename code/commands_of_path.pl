#!/usr/bin/env perl
use CurrentPerl;

foreach my $dir (split /:/, $ENV{'PATH'}) {
    if (opendir my $dh, $dir) {
        grep {!/^[.]/ && print "$_\n"} readdir $dh;
        closedir $dh;
    } else {
        warn "Can't open dir $dir: $OS_ERROR\n";
    }
}
