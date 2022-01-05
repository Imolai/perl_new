package NewPerl 2022;

use feature ':5.32';
use utf8;
use warnings;
use open qw(:std :utf8);
no feature qw(indirect);
use feature qw(signatures);
no warnings qw(experimental::signatures);
use autodie qw(:all);
use IO::File   ();
use IO::Handle ();

sub import {
    my ($class, $date) = @_;
    feature->import(':5.32');
    warnings->import;
}
 
sub unimport {
    feature->unimport;
    warnings->unimport;
}

1;
