#!/usr/bin/env perl
use NewPerl;

sub foo ($parameter1, $parameter2 = 1, @rest) {
    say "You passed me $parameter1 and $parameter2";
    say "And these:";
    say for @rest;
}

foo 'first', 'second', 'third', 'fourth', 'fifth';
