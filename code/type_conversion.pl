#!/usr/bin/env perl
use CurrentPerl;
use Scalar::Util qw(looks_like_number);

my $a = 100;
my $b = 7;

say $a + $b;
say $a . $b;
say $a * $b;
say $a x $b;
say $a > $b  ? 'true' : 'false';
say $a gt $b ? 'true' : 'false';

my $x = "4T";
my $y = 3;

say $x . $y;    # 4T3
if (looks_like_number($x)) {
    say $x + $y;    # 7
                    # Argument "4T" isn't numeric in addition (+) at ..
} else {
    no warnings;    # Try without warnings.
    say $x + $y;    # 7
}

