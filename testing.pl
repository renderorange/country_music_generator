#!/usr/bin/perl

use strict;
use warnings;

use CGI;
my $q = CGI->new;

### input
my $syllables = $q->param('syllables');
my $lines = $q->param('lines');

# validate
if (!$syllables || !$lines) { die "error: params appear to be missing\n"; }
if ($syllables !~ /(\d+)/ || $lines !~ /(\d+)/) { die "error: param input must be numeric\n"; }
if ($syllables < 5 || $syllables > 10) { die "warning: Whoa partner, what kind of country music you lookin for?\n"; }
if ($lines < 1) { die "warning: I can't sing you nothing, now can I?\n"; } 
elsif ($lines > 50) { die "warning: What, you think this is 'merican Pie or somethin?\n"; }

