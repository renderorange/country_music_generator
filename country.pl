#!/usr/bin/perl

use strict;
use warnings;

use CGI;
my $q = CGI->new;

# get input
my $total_syllables=$q->param('syllables');
my $total_lines=$q->param('lines');

print "Content-Type:text/html\r\n\r\n";

# and validate it
if (!$total_syllables || !$total_lines) { print_error('error: params appear to be missing'); }
if ($total_syllables !~ /(\d+)/ || $total_lines !~ /(\d+)/) { print_error('error: param input must be numeric'); }
if ($total_syllables < 5 || $total_syllables > 10) { print_error('warning: Whoa partner, what kind of country music you lookin for?'); }
if ($total_lines < 1) { print_error('warning: Aint no song made of nothing, is it?'); } 
elsif ($total_lines > 50) { print_error("warning: What, you think this is 'merican Pie or somethin?"); }

# the data, categorized by number of syllables
my %words = (
    '1' => ['beer', 'dog', 'bar', 'truck', 'walk', 'ride', 'drive', 'sway', 'he', 'she', 'it', 'her', 'my', 'you', 'land', 'free', 'brave', 'dirt', 'road', 'farm', 'corn', 'wheat', 'can', 'case', 'gin', 'shot', 'glass', 'drink', 'drunk', 'the', 'his', 'gun', 'dogs', 'boots', 'belt', 'red', 'white', 'blue', 'jeans', 'night', 'girl', 'boy', 'girls', 'boys', 'dance', 'crick', 'creek', 'dock', 'done', 'love', 'field'],
    '2' => ['girlfriend', 'weddin', 'chicken', 'bluejeans', 'dirtroad', 'rifle', 'river', 'buckle', 'lazy', 'chevy', 'freedom', 'jesus', 'gravel', 'tractor', 'bottle', 'whiskey', 'drinking', 'drinkin\'', 'the boys', 'ladies', 'shotgun', 'dirt road', 'bonfire', 'highway', 'small town', 'farmer', 'country', 'square dance', 'line dance', 'hodown', 'fishing', 'fishin\'', 'truckin\'', 'flatbed', 'off road', 'shit-faced', 'cheated', 'cheatin\'', 'walkin\'', 'over'],
    '3' => ['honkeytonk', 'swaggerin', 'saunterin', 'moseyin', 'tequelia', 'blue collar', 'afternoon', 'four-by-four', 'off roadin\''],
#    '4' => ['red white and blue'],
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
    print "<br>";
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

sub print_error {
    my $error = shift;
    print "$error\n" and die "$error";
}
