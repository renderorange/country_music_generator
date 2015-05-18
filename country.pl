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

# the data, categorized by number of syllables
my %words = (
    '1' => ['beer', 'dog', 'bar', 'truck', 'walk', 'ride', 'drive', 'sway'],
    '2' => ['girlfriend', 'weddin', 'chicken', 'bluejeans', 'dirtroad'],
    '3' => ['honkeytonk', 'swaggerin', 'saunterin', 'moseyin'],
);

# build and output the sentences
for (my $line = 0; $line < $total_lines; ++$line) {  # loop for the amount of total_lines
    my $syllable = 0; 
    while ($syllable < $total_syllables) {  # loop until total_syllables are satisfied
        my $remaining = $total_syllables - $syllable;
        my ($random_syllables, $random_word);
        if ($remaining <= keys %words) {  # if the remaining syllables in the sentence can be satisfied by a specific syllable tier
            ($random_syllables, $random_word) = get_random_word($remaining);  # then get a word in that specific syllable tier
        } else {
            ($random_syllables, $random_word) = get_random_word();  # otherwise get random
        }
        $syllable += $random_syllables;
        print "$random_word ";
    }
    print "\n";
}

# subs
sub get_random_word {
    my $random_syllable = shift;  # if a number is passed in, get from that syllable tier
    if (! defined $random_syllable) {
        $random_syllable = int(rand(scalar keys %words)) + 1;  # otherwise, get from a random syllable tier
    }
    my $random_array_size = scalar @{$words{$random_syllable}};
    my $random_word_number = int(rand($random_array_size));
    my $random_word = $words{$random_syllable}[$random_word_number];
    return ($random_syllable, $random_word);
}
