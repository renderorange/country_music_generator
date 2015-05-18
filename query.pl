#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Long;

# get input
my ($syllables, $lines);
GetOptions ( "syllables=i" => \$syllables,
             "lines=i"     => \$lines );
# and validate it
if (!$syllables || !$lines) { die "error: params appear to be missing\n"; }
if ($syllables !~ /(\d+)/ || $lines !~ /(\d+)/) { die "error: param input must be numeric\n"; }
if ($syllables < 5 || $syllables > 10) { die "warning: Whoa partner, what kind of country music you lookin for?\n"; }
if ($lines < 1) { die "warning: Ain't no song made of nothing, is it?\n"; } 
elsif ($lines > 50) { die "warning: What, you think this is 'merican Pie or somethin?\n"; }

# the data, categorized by type and number of syllables
my %words = (
    '1' => [ 'beer', 'dog', 'bar', 'truck', 'walk', 'ride', 'drive', 'sway' ],
    '2' => [ 'girlfriend', 'wedding', 'chicken', 'bluejeans', 'dirtroad' ],
    '3' => [ 'honkeytonk', 'swaggerin', 'saunterin', 'moseyin' ],
);

# build up the sentence
print scalar @{ $words{int(rand(scalar keys %words)) + 1} } - 1;  # random hash key, length of the array, minus 1
