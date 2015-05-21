#!/usr/bin/perl

use Spreadsheet::XLSX;
 
my $excel = Spreadsheet::XLSX -> new ('country_song.xlsx', $converter);
foreach my $sheet (@{$excel -> {Worksheet}}) {
    printf("Sheet: %s\n", $sheet->{Name});
    $sheet -> {MaxRow} ||= $sheet -> {MinRow};
    foreach my $row ($sheet -> {MinRow} .. $sheet -> {MaxRow}) {
        $sheet -> {MaxCol} ||= $sheet -> {MinCol};
        foreach my $col ($sheet -> {MinCol} ..  $sheet -> {MaxCol}) {
            my $cell = $sheet -> {Cells} [$row] [$col];
            if ($cell) {
                printf("( %s , %s ) => %s\n", $row, $col, $cell -> {Val});
                #if ($cell -> {Val} == 4 { print "'" . $sheet -> {Cells} [$row] [$col - 1] -> {Val} . "', " }
            }
        }
    }
}
