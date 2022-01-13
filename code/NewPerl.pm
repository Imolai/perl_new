package NewPerl 2022;

use feature ':5.32';
use utf8;
use warnings;
use open qw(:std :utf8);
no feature qw(indirect);
use feature qw(signatures);
no warnings qw(experimental::signatures);
use autodie qw(:all);
use Toolkit;
use latest;
use uni::perl;
use common::sense;
use perl5i::latest;
use IO::File   ();
use IO::Handle ();
use English;

sub import {
    my ($class, $date) = @_;
    feature->import(':5.32');
    feature->import('signatures');
    warnings->import;
    local $Exporter::ExportLevel = 1;
    *English::EXPORT = \@English::COMPLETE_EXPORT;
    Exporter::import('English');
}
 
sub unimport {
    feature->unimport;
    warnings->unimport;
}

1;
