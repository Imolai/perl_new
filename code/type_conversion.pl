#!/usr/bin/perl
use NewPerl;
use Scalar::Util qw(looks_like_number);

my $x = "4T";
my $y = 3;

say $x . $y;      # 4T3
if (looks_like_number($x)) {
    say $x + $y;  # 7
                    # Argument "4T" isn't numeric in addition (+) at ..
} else {
    no warnings;  # Try without warnings.
    say $x + $y;  # 7
}

