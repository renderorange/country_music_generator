#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Long;

# get input
my ($total_syllables, $total_lines);
GetOptions ( "syllables=i" => \$total_syllables,
             "lines=i"     => \$total_lines );
# and validate it
if (!$total_syllables || !$total_lines) { die "error: params appear to be missing\n"; }
if ($total_syllables !~ /(\d+)/ || $total_lines !~ /(\d+)/) { die "error: param input must be numeric\n"; }
if ($total_syllables < 5 || $total_syllables > 10) { die "warning: Whoa partner, what kind of country music you lookin for?\n"; }
if ($total_lines < 1) { die "warning: Ain't no song made of nothing, is it?\n"; } 
elsif ($total_lines > 50) { die "warning: What, you think this is 'merican Pie or somethin?\n"; }

# the data, categorized by type and number of syllables
my %words = (
    '1' => [ 'beer', 'dog', 'bar', 'truck', 'walk', 'ride', 'drive', 'sway' ],
    '2' => [ 'girlfriend', 'wedding', 'chicken', 'bluejeans', 'dirtroad' ],
    '3' => [ 'honkeytonk', 'swaggerin', 'saunterin', 'moseyin' ],
);

# build up the sentence
for (my $line = 0; $line < $total_lines; ++$line) {
    for (my $syllable = 0; $syllable < $total_syllables; ++$syllable) {
        my ($random_syllables, $random_word) = get_random_word();
        print "[$random_syllables] $random_word ";
    }
    print "\n";
}

# subs
sub get_random_word {
    my $random_syllable = int(rand(scalar keys %words)) + 1;
    my $random_array_size = scalar @{ $words{ $random_syllable } };
    my $random_word_number = int(rand($random_array_size - 1));
    my $random_word = $words{$random_syllable}[ $random_word_number ];
    return ($random_syllable, $random_word);
}
