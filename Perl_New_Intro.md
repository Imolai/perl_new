# Perl New Intro

For the new, modern Perl (7) in 2022

Or the Misunderstood Perl, the language everyone thinks they know, although doesn't really know nearly enough about it to be competent.


## Reason to being

This document is not a new one, I simply copy-pasted the newest and most important parts of existing documentations:

- [Perl Intro](https://perldoc.perl.org/perlintro)
- [Minimum Viable Perl](http://mvp.kablamo.org/)
- [Announcing Perl 7](https://www.perl.com/article/announcing-perl-7/)
- [34 at 34 for v5.34: Modern Perl features for Perl’s birthday](https://phoenixtrap.com/2021/12/21/34-at-34-for-v5-34-modern-perl-features-for-perls-birthday/)
- [Modern Perl](http://modernperlbooks.com/books/modern_perl_2016/)



## Perl 7 is going to be Perl 5.32, mostly

Perl 7.0 is going to be v5.32 but with different, saner, more modern defaults.

## What is Perl?

Perl is a general-purpose programming language originally developed  for text manipulation and now used for a wide range of tasks including  system administration, web development, network programming, GUI  development, and more.

## Installing bleading-edge Perl with Perlbrew

perlbrew is an admin-free perl installation management tool. The latest version is 0.94, read the release note: [Release 0.94](https://perlbrew.pl/Release-0.94.html).

For a quick installation, do this:

```bash
\curl -L https://install.perlbrew.pl | bash
```

Check the document of [Installation](https://perlbrew.pl/Installation.html) for more descriptions and options.

To install the latest stable release, and use it from now on:

```bash
perlbrew install perl-5.34.0
perlbrew switch perl-5.34.0
```

To play with the bleeding-edge version, but only in the current shell:

```bash
perlbrew install perl-blead
perlbrew use perl-blead
```

## Installing libraries with cpanm

The best way to install modules is with [cpanm](https://metacpan.org/pod/distribution/App-cpanminus/lib/App/cpanminus/fatscript.pm).

### How to install cpanm

Hopefully its already installed, but if not:

```bash
curl -L https://cpanmin.us | perl - --sudo App::cpanminus
```

### Basic usage

```bash
cpanm --help         # get help
cpanm URI            # install the URI module from CPAN
cpanm DateTime@1.44  # install version 1.44
```

## What version? Where?

The best way to find out what version of a module is installed and where is to use [pmtools](https://metacpan.org/pod/pmtools).

### How do I Install pmtools?

```bash
$ cpanm pmtools
```

### What version of that module is installed?

```bash
$ pmvers Moo
2.005004
```

### Where is that module installed?

```bash
$ pmpath Moo
/home/user/perl5/perlbrew/perls/perl-5.34.0/lib/site_perl/5.34.0/Moo.pm
```

## Running Perl programs

To run a Perl program from the Unix command line:

```bash
perl progname.pl
```

Alternatively, put this as the first line of your script:

```perl
#!/usr/bin/env perl
```

... and run the script as */path/to/script.pl*. Of course, it'll need to be executable first, so `chmod 755 script.pl` (under Unix).

## Modern defaults

Perl by default is very forgiving. In order to make it more robust it is recommended to start every program with the following lines:

```perl
#!/usr/bin/perl
use v5.32;  # OR use feature ':5.32';
use utf8;
use warnings;
use open qw(:std :utf8);
no feature qw(indirect);
use feature qw(signatures);
no warnings qw(experimental::signatures);

use autodie qw(:all);   # Recommended more: defaults and system/exec.
```

## Basic syntax overview

A Perl script or program consists of one or more statements. These  statements are simply written in the script in a straightforward  fashion. There is no need to have a `main()` function or anything of that kind.

Perl statements end in a semi-colon:

```perl
say "Hello, world";
```

Comments start with a hash symbol and run to the end of the line

```perl
# This is a comment
```

Whitespace is irrelevant:

```perl
say
    "Hello, world"
    ;
```

... except inside quoted strings:

```perl
# this would print with a linebreak in the middle
say "Hello
world";
```

Double quotes or single quotes may be used around literal strings:

```perl
say "Hello, world";
say 'Hello, world';
```

However, only double quotes "interpolate" variables and special characters such as newlines (`\n`):

```perl
print "Hello, $name\n";     # works fine
print 'Hello, $name\n';     # prints $name\n literally
```

Numbers don't need quotes around them:

```perl
say 42;
```

You can use parentheses for functions' arguments or omit them  according to your personal taste. They are only required occasionally to clarify issues of precedence.

```perl
print("Hello, world\n");
print "Hello, world\n";
```

More detailed information about Perl syntax can be found in [perlsyn](https://perldoc.perl.org/perlsyn).

## Perl variable types

Perl has three main variable types: scalars, arrays, and hashes.

### Scalars

A scalar represents a single value:

```perl
my $animal = "camel";
my $answer = 42;
```

Scalar values can be strings, integers or floating point numbers, and Perl will automatically convert between them as required. There is no  need to pre-declare your variable types, but you have to declare them  using the `my` keyword the first time you use them. (This is one of the requirements of `use strict;`.)

Scalar values can be used in various ways:

```perl
say $animal;
print "The animal is $animal\n";
print "The square of $answer is ", $answer * $answer, "\n";
```

There are a number of "magic" scalars with names that look like  punctuation or line noise. These special variables are used for all  kinds of purposes, and are documented in [perlvar](https://perldoc.perl.org/perlvar). The only one you need to know about for now is `$_` which is the "default variable". It's used as the default argument to a number of functions in Perl, and it's set implicitly by certain looping constructs. 

```perl
say;          # prints contents of $_ by default
```

### Arrays

  An array represents a list of values:

```perl
my @animals = ("camel", "llama", "owl");
my @numbers = (23, 42, 69);
my @mixed   = ("camel", 42, 1.23);
```

Arrays are zero-indexed. Here's how you get at elements in an array:

```perl
say $animals[0];              # prints "camel"
say $animals[1];              # prints "llama"
```

The special variable `$#array` tells you the index of the last element of an array:

```perl
say $mixed[$#mixed];       # last element, prints 1.23
```

You might be tempted to use `$#array + 1` to tell you how many items there are in an array. Don't bother. As it happens, using `@array` where Perl expects to find a scalar value ("in scalar context") will give you the number of elements in the array:

```perl
if (@animals < 5) {
	...
}
```

The elements we're getting from the array start with a `$` because we're getting just a single value out of the array; you ask for a scalar, you get a scalar.

You can do various useful things to lists:

```perl
my @sorted    = sort @animals;
my @backwards = reverse @numbers;
```

 There are a couple of special arrays too, such as `@ARGV` (the command line arguments to your script) and `@_` (the arguments passed to a subroutine). These are documented in [perlvar](https://perldoc.perl.org/perlvar).

#### Array slices

To get multiple values from an array:

```perl
@animals[0,1];                 # gives ("camel", "llama");
@animals[0..2];                # gives ("camel", "llama", "owl");
@animals[1..$#animals];        # gives all except the first element` 
```

This is called an "array slice".

### Hashes

A hash represents a set of key/value pairs:

```perl
my %fruit_color = ("apple", "red", "banana", "yellow");
```

You can use whitespace and the `=>` operator to lay them out more nicely:

```perl
my %fruit_color = (
    apple  => "red",
    banana => "yellow",
);
```

To get at hash elements:

```perl
$fruit_color{"apple"};           # gives "red"
```

You can get at lists of keys and values with `keys()`, `values()` and `each`.

```perl
my @fruits = keys %fruit_color;
my @colors = values %fruit_color;
while (my ($key, $value) = each %ENV) {  # prints out your environment like the printenv(1)
    print "$key=$value\n";
}
```

You can use `each` to iterate over an array’s indices and values at the same time:

```perl
while (my ($index, $value) = each @array) {
    ...
}
```

Hashes have no particular internal order, though you can sort the keys and loop through them. Just like special scalars and arrays, there are also special hashes. The most well known of these is `%ENV` which contains environment variables. Read all about it (and other special variables) in [perlvar](https://perldoc.perl.org/perlvar).

#### Hash slices

The [`%foo{'bar', 'baz'}` syntax](https://perldoc.perl.org/perl5200delta#New-slice-syntax) enables you to [slice a subset of a hash](https://perldoc.perl.org/perldata#Key%2FValue-Hash-Slices) with its keys and values intact. Very helpful for cherry-picking or aggregating many hashes into one. For example:

```perl
my %args = (
    verbose => 1,
    name    => 'Mark',
    extra   => 'pizza',
);
# don't frob the pizza
$my_object->frob( %args{ qw(verbose name) };
```



Scalars, arrays and hashes are documented more fully in [perldata](https://perldoc.perl.org/perldata).

More complex data types can be constructed using references, which allow you to build lists and hashes within lists and hashes.

A reference is a scalar value and can refer to any other Perl data  type. So by storing a reference as the value of an array or hash  element, you can easily create lists and hashes within lists and hashes. The following example shows a 2 level hash of hash structure using  anonymous hash references.

```bash
my $variables = {
    scalar  =>  {
                 description => "single item",
                 sigil => '$',
                },
    array   =>  {
                 description => "ordered list of items",
                 sigil => '@',
                },
    hash    =>  {
                 description => "key/value pairs",
                 sigil => '%',
                },
};

print "Scalars begin with a $variables->{'scalar'}->{'sigil'}\n";
```

Exhaustive information on the topic of references can be found in [perlreftut](https://perldoc.perl.org/perlreftut), [perllol](https://perldoc.perl.org/perllol), [perlref](https://perldoc.perl.org/perlref) and [perldsc](https://perldoc.perl.org/perldsc).

## Variable scoping

Throughout the previous section all the examples have used the syntax:

```perl
my $var = "value";
```

The `my` is actually not required; you could just use:

```perl
$var = "value";
```

However, the above usage will create global variables throughout your program, which is bad programming practice. `my` creates lexically scoped variables instead. The variables are scoped to the block (i.e. a bunch of statements surrounded by curly-braces) in  which they are defined.

```perl
my $x = "foo";
my $some_condition = 1;
if ($some_condition) {
    my $y = "bar";
    say $x;           # prints "foo"
    say $y;           # prints "bar"
}
say $x;               # prints "foo"
say $y;               # prints nothing; $y has fallen out of scope
```

Using `my` in combination with a `use strict;`  at the top of your Perl scripts means that the interpreter will pick up  certain common programming errors. For instance, in the example above,  the final `say $y` would cause a compile-time error and prevent you from running the program. Using `strict` is highly recommended.

### Persistent variables via state()

Beginning with Perl 5.10.0, you can declare variables with the `state` keyword in place of `my`. For that to work, though, you must have enabled that feature beforehand, either by using the `feature` pragma, or by using `-E` on one-liners (see [feature](https://perldoc.perl.org/feature)). Beginning with Perl 5.16, the `CORE::state` form does not require the `feature` pragma.

The `state` keyword creates a lexical variable (following the same scoping rules as `my`) that persists from one subroutine call to the next. If a state variable resides inside an anonymous subroutine, then each copy of the  subroutine has its own copy of the state variable. However, the value of the state variable will still persist between calls to the same copy of the anonymous subroutine. (Don't forget that `sub { ... }` creates a new subroutine each time it is executed.)

For example, the following code maintains a private counter, incremented each time the gimme_another() function is called:

```perl
use feature 'state';
sub gimme_another {
	state $x;
	return ++$x
}
```

## Conditional and looping constructs

Perl has most of the usual conditional and looping constructs. As of Perl 5.10, it even has a case/switch statement (spelled `given`/`when`). See ["Switch Statements" in perlsyn](https://perldoc.perl.org/perlsyn#Switch-Statements) for more details.

The conditions can be any Perl expression. See the list of operators  in the next section for information on comparison and boolean logic  operators, which are commonly used in conditional statements.

### if

  `if ( condition ) {    ... } elsif ( other condition ) {    ... } else {    ... }` There's also a negated version of it: `unless ( condition ) {    ... }` This is provided as a more readable version of `if (!*condition*)`. Note that the braces are required in Perl, even if you've only got  one line in the block. However, there is a clever way of making your  one-line conditional blocks more English like: `# the traditional way if ($zippy) {    say "Yow!"; } # the Perlish post-condition way say "Yow!" if $zippy; say "We have no bananas" unless $bananas;`

### given

Starting from Perl 5.10.1 (well, 5.10.0, but it didn't work right), you can use an experimental switch feature. This is loosely based on an old version of a Raku proposal, but it no longer resembles the Raku construct. You also get the switch feature whenever you declare that your code prefers to run under a version of Perl that is 5.10 or later. The keywords given and when are analogous to switch and case in other languages -- though continue is not -- so the code in the previous section could be rewritten as

```perl
for ($var) {
    when (/^abc/) { $abc = 1 }
    when (/^def/) { $def = 1 }
    when (/^xyz/) { $xyz = 1 }
    default       { $nothing = 1 }
}
```

The foreach is the non-experimental way to set a topicalizer. If you wish to use the highly experimental given, that could be written like this:

```perl
given ($var) {
    when (/^abc/) { $abc = 1 }
    when (/^def/) { $def = 1 }
    when (/^xyz/) { $xyz = 1 }
    default       { $nothing = 1 }
}
```

You can use the [experimental switch feature](https://perldoc.perl.org/perlsyn#Switch-Statements)’s `when` keyword as a postfix modifier also. For example:

```perl
for ($foo) {
    $a =  1 when /^abc/;
    $a = 42 when /^dna/;
    ...
}
```

### while

  `while ( condition ) {    ... }` There's also a negated version, for the same reason we have `unless`: `until ( condition ) {    ... }` You can also use `while` in a post-condition: `print "LA LA LA\n" while 1;          # loops forever`

### for

  Exactly like C: `for ($i = 0; $i <= $max; $i++) {    ... }` The C style for loop is rarely needed in Perl since Perl provides the more friendly list scanning `foreach` loop.

### foreach

  `foreach (@array) {    print "This element is $_\n"; } say $list[$_] foreach 0 .. $max; # you don't have to use the default $_ either... foreach my $key (keys %hash) {    print "The value of $key is $hash{$key}\n"; }` The `foreach` keyword is actually a synonym for the `for` keyword. See `"Foreach Loops" in perlsyn`.

For more detail on looping constructs (and some that weren't mentioned in this overview) see [perlsyn](https://perldoc.perl.org/perlsyn).

## Builtin operators and functions

Perl comes with a wide selection of builtin functions. Some of the ones we've already seen include `print`, `sort` and `reverse`. A list of them is given at the start of [perlfunc](https://perldoc.perl.org/perlfunc) and you can easily read about any given function by using `perldoc -f *functionname*`.

Perl operators are documented in full in [perlop](https://perldoc.perl.org/perlop), but here are a few of the most common ones:

- Arithmetic

  `+   addition -   subtraction *   multiplication /   division`

- Numeric comparison

  `==  equality !=  inequality <   less than >   greater than <=  less than or equal >=  greater than or equal`

- String comparison

  `eq  equality ne  inequality lt  less than gt  greater than le  less than or equal ge  greater than or equal` (Why do we have separate numeric and string comparisons? Because we  don't have special variable types, and Perl needs to know whether to  sort numerically (where 99 is less than 100) or alphabetically (where  100 comes before 99).

- Boolean logic

  `&&  and ||  or !   not` (`and`, `or` and `not` aren't just  in the above table as descriptions of the operators. They're also  supported as operators in their own right. They're more readable than  the C-style operators, but have different precedence to `&&` and friends. Check [perlop](https://perldoc.perl.org/perlop) for more detail.)

- Miscellaneous

  `=   assignment .   string concatenation x   string multiplication (repeats strings) ..  range operator (creates a list of numbers or strings)`

Many operators can be combined with a `=` as follows:

```
$a += 1;        # same as $a = $a + 1
$a -= 1;        # same as $a = $a - 1
$a .= "\n";     # same as $a = $a . "\n";
```

### The defined-or operator

This is an easy win [from Perl v5.10](https://perldoc.perl.org/perl5100delta#Defined-or-operator):

```
defined $foo ? $foo : $bar  # replace this
$foo // $bar                # with this
```

And:

```
$foo = $bar unless defined $foo  # replace this
$foo //= $bar                    # with this
```

## Files and I/O

You can open a file for input or output using the `open()` function. It's documented in extravagant detail in [perlfunc](https://perldoc.perl.org/perlfunc) and [perlopentut](https://perldoc.perl.org/perlopentut), but in short:

```
open(my $in,  "<",  "input.txt")  or die "Can't open input.txt: $!";
open(my $out, ">",  "output.txt") or die "Can't open output.txt: $!";
open(my $log, ">>", "my.log")     or die "Can't open my.log: $!";
```

You can read from an open filehandle using the `<>`  operator. In scalar context it reads a single line from the filehandle,  and in list context it reads the whole file in, assigning each line to  an element of the list:

```
my $line  = <$in>;
my @lines = <$in>;
```

Reading in the whole file at one time is called slurping. It can be  useful but it may be a memory hog. Most text file processing can be done a line at a time with Perl's looping constructs.

The `<>` operator is most often seen in a `while` loop:

```
while (<$in>) {     # assigns each line in turn to $_
    print "Just read in this line: $_";
}
```

We've already seen how to print to standard output using `print()`. However, `print()` can also take an optional first argument specifying which filehandle to print to:

```
print STDERR "This is your final warning.\n";
print $out $record;
print $log $logmessage;
```

When you're done with your filehandles, you should `close()` them (though to be honest, Perl will clean up after you if you forget):

```
close $in or die "$in: $!";
```

## Regular expressions

Perl's regular expression support is both broad and deep, and is the subject of lengthy documentation in [perlrequick](https://perldoc.perl.org/perlrequick), [perlretut](https://perldoc.perl.org/perlretut), and elsewhere. However, in short:

- Simple matching

  `if (/foo/)       { ... }  # true if $_ contains "foo" if ($a =~ /foo/) { ... }  # true if $a contains "foo"` The `//` matching operator is documented in [perlop](https://perldoc.perl.org/perlop). It operates on `$_` by default, or can be bound to another variable using the `=~` binding operator (also documented in [perlop](https://perldoc.perl.org/perlop)).

- Simple substitution

  `s/foo/bar/;               # replaces foo with bar in $_ $a =~ s/foo/bar/;         # replaces foo with bar in $a $a =~ s/foo/bar/g;        # replaces ALL INSTANCES of foo with bar                          # in $a` The `s///` substitution operator is documented in [perlop](https://perldoc.perl.org/perlop).

- More complex regular expressions

  You don't just have to match on fixed strings. In fact, you can match on just about anything you could dream of by using more complex regular expressions. These are documented at great length in [perlre](https://perldoc.perl.org/perlre), but for the meantime, here's a quick cheat sheet: `.                   a single character \s                  a whitespace character (space, tab, newline,                    ...) \S                  non-whitespace character \d                  a digit (0-9) \D                  a non-digit \w                  a word character (a-z, A-Z, 0-9, _) \W                  a non-word character [aeiou]             matches a single character in the given set [^aeiou]            matches a single character outside the given                    set (foo|bar|baz)       matches any of the alternatives specified ^                   start of string $                   end of string` Quantifiers can be used to specify how many of the previous thing you want to match on, where "thing" means either a literal character, one  of the metacharacters listed above, or a group of characters or  metacharacters in parentheses. `*                   zero or more of the previous thing +                   one or more of the previous thing ?                   zero or one of the previous thing {3}                 matches exactly 3 of the previous thing {3,6}               matches between 3 and 6 of the previous thing {3,}                matches 3 or more of the previous thing` Some brief examples: `/^\d+/              string starts with one or more digits /^$/                nothing in the string (start and end are                    adjacent) /(\d\s){3}/         three digits, each followed by a whitespace                    character (eg "3 4 5 ") /(a.)+/             matches a string in which every odd-numbered                    letter is a (eg "abacadaf") # This loop reads from STDIN, and prints non-blank lines: while (<>) {    next if /^$/;    print; }`

- Parentheses for capturing

  As well as grouping, parentheses serve a second purpose. They can be  used to capture the results of parts of the regexp match for later use.  The results end up in `$1`, `$2` and so on. `# a cheap and nasty way to break an email address up into parts if ($email =~ /([^@]+)@(.+)/) {    print "Username is $1\n";    print "Hostname is $2\n"; }`

- Other regexp features

  Perl regexps also support backreferences, lookaheads, and all kinds of other complex details. Read all about them in [perlrequick](https://perldoc.perl.org/perlrequick), [perlretut](https://perldoc.perl.org/perlretut), and [perlre](https://perldoc.perl.org/perlre).

## Functions, subroutines

Writing functions or subroutines is easy:

```
sub logger {
   my $logmessage = shift;
   open my $logfile, ">>", "my.log" or die "Could not open my.log: $!";
   print $logfile $logmessage;
}
```

Now we can use the subroutine just as any other built-in function:

```
logger("We have a logger subroutine!");
```

What's that `shift`? Well, the arguments to a subroutine are available to us as a special array called `@_` (see [perlvar](https://perldoc.perl.org/perlvar) for more on that). The default argument to the `shift` function just happens to be `@_`. So `my $logmessage = shift;` shifts the first item off the list of arguments and assigns it to `$logmessage`.

We can manipulate `@_` in other ways too:

```
my ($logmessage, $priority) = @_;       # common
my $logmessage = $_[0];                 # uncommon, and ugly
```

Subroutines can also return values:

```
sub square {
    my $num = shift;
    my $result = $num * $num;
    return $result;
}
```

Then use it like:

```
$sq = square(8);
```

For more information on writing subroutines, see [perlsub](https://perldoc.perl.org/perlsub).

## Packages, modules

Perl v5.12 helped reduce clutter by enabling a [`package` namespace declaration](https://perldoc.perl.org/functions/package) to [also include a version number](https://perldoc.perl.org/perl5120delta#New-package-NAME-VERSION-syntax), instead of requiring a separate `our $VERSION = ...;`:

```perl
package Local::NewHotness v1.2.3 {
	...  # The ... ellipsis statement (colloquially “yada-yada”) gives you an easy placeholder for yet-to-be-implemented code.
}
```

Perl modules provide a range of features to help you avoid reinventing the wheel, and can be downloaded from CPAN ( http://www.cpan.org/ ). A number of popular modules are included with the Perl distribution itself.

Categories of modules range from text manipulation to network  protocols to database integration to graphics. A categorized list of  modules is also available from CPAN.

To learn how to install modules you download from CPAN, read [perlmodinstall](https://perldoc.perl.org/perlmodinstall).

To learn how to use a particular module, use `perldoc *Module::Name*`. Typically you will want to `use *Module::Name*`, which will then give you access to exported functions or an OO interface to the module.

[perlfaq](https://perldoc.perl.org/perlfaq) contains questions and answers related to many common tasks, and often provides suggestions for good CPAN modules to use.

[perlmod](https://perldoc.perl.org/perlmod) describes Perl modules in general. [perlmodlib](https://perldoc.perl.org/perlmodlib) lists the modules which came with your Perl installation.

If you feel the urge to write Perl modules, [perlnewmod](https://perldoc.perl.org/perlnewmod) will give you good advice.

## Try Catch Exception Handling  

[This year’s Perl v5.34 release](https://www.nntp.perl.org/group/perl.perl5.porters/2021/05/msg260110.html) introduced [experimental `try`/`catch` syntax](https://perldoc.perl.org/perlsyn#Try-Catch-Exception-Handling) for exception handling. The `try`/`catch` syntax provides control flow relating to exception handling. The `try` keyword introduces a block which will be executed when it is encountered, and the `catch` block provides code to handle any exception that may be thrown by the first.

```perl
try {
    my $x = call_a_function();
    $x < 100 or die "Too big";
    send_output($x);
}
catch ($e) {
    warn "Unable to output a value; $e";
}
print "Finished\n";
```

Here, the body of the `catch` block (i.e. the `warn` statement) will be executed if the initial block invokes the conditional `die`, or if either of the functions it invokes throws an uncaught exception. The `catch` block can inspect the `$e` lexical variable in this case to see what the exception was. If no exception was thrown then the `catch` block does not happen. In either case, execution will then continue from the following statement - in this example the `print`.

## OO Perl

OO Perl is relatively simple and is implemented using references  which know what sort of object they are based on Perl's concept of  packages. However, OO Perl is largely beyond the scope of this document. Read [perlootut](https://perldoc.perl.org/perlootut) and [perlobj](https://perldoc.perl.org/perlobj).

As a beginning Perl programmer, your most common use of OO Perl will  be in using third-party modules, which are documented below.

Simple class inheritance with use parent
Sometimes in older object-oriented Perl code, you’ll see use base as a pragma to establish inheritance from another class. Older still is the direct manipulation of the package’s special @ISA array. In most cases, both should be avoided in favor of use parent, which was added to core in Perl v5.10.1.

Test for class membership with the isa operator
As an alternative to the isa() method provided to all Perl objects, Perl v5.32 introduced the experimental isa infix operator:

$my_object->isa('Local::MyClass')
# or
$my_object isa Local::MyClass

\# TODO continue from Simple class inheritance with `use parent`
