use Test::Base;

plan 'no_plan';

use FindBin;
use Text::MicroTemplate::Extended;

my $mt = Text::MicroTemplate::Extended->new(
    include_path => [ "$FindBin::Bin/templates" ],
    use_cache    => 2,
    template_args => {
        foo => 'foo!',
        bar => { bar => 'bar!!!' },
    },
);

sub render {
    $mt->render($_[0]);
}

filters {
    input => ['render'],
};

run_compare;
run_compare; # test for cache

__DATA__

=== simple template test
--- input: simple
--- expected
simple simple simple
true

=== base template
--- input: base
--- expected
base title
content

=== sub base template (1)
--- input: subbase
--- expected
sub title
content

=== sub base template (2)
--- input: subbase2
--- expected
sub!
title!
sub!

content

=== content template (extended base)
--- input: content
--- expected
base title
content modified

=== content template (extended subbase)
--- input: subcontent
--- expected
sub title
content modified

=== template args
--- input: args
--- expected
foo!
bar!!!