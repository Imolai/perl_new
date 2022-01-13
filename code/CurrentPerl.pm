package CurrentPerl 2022;

# The Modern Perl features and modules in 2022.

use feature qw(:5.32);
use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
no feature qw(indirect);
use feature qw(signatures);
no warnings qw(experimental::signatures);
use autodie qw(:all);
use re qw(/xms);
use Carp qw(carp croak confess cluck);
use English qw(-no_match_vars);
use Exporter;
use IO::File;
use IO::Handle;

sub import {
    feature->import(':5.32');
    strict->import();
    warnings->import;
    utf8->import();
    feature->import(qw(signatures));
    autodie->import(qw(:all));
    re->import(qw(/xms));
    Carp->import(qw(carp croak confess cluck));
    IO::File->import();
    IO::Handle->import();
    local $Exporter::ExportLevel = 1;
    *English::EXPORT = \@English::COMPLETE_EXPORT;
    Exporter::import('English');
    return;
}

sub unimport {
    warnings->unimport;
    strict->unimport;
    feature->unimport;
    return;
}

1;
