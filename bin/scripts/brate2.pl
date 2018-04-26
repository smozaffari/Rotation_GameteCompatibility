#!/usr/bin/perl

use strict;
use warnings;

my %parents;
my $proci=0;
my $children=0;
my %info;
my %childid;
my %bday;
my $m = "mom";
my $d = "dad";
my $md = "marriageyear";
my $mbday= "mombday";
my $dbday = "dadsbday";
my %lastbirth;
my $birthinterval=0;
my %bi;
my $previousinterval;
my $previousbirth;

open (CHD, "../../results/children/correctchildren_updated") || die "nope: $! ";
#open (CHD, "out_no-children.tsv") || die "nope: $!";

while (my $line = <CHD>) {
    chomp $line;
    my @line = split("\t", $line);
    my @date = split("-", $line[1]);
    my @mom = split("-", $line[3]);
    my @dad = split("-", $line[5]);
    if ($proci == $line[0]) {
	$children++;
	push @{ $childid{$proci} }, $line[6];
	push @{ $bday{$proci} }, $line[8];
	$previousinterval = $line[8]-$previousbirth;
	if ($previousinterval == 0) {
	    $children = $children-1;
	}
	$birthinterval+=$previousinterval;
	$lastbirth{$proci} = $line[8];
	print ("$proci\t$previousbirth\t$previousinterval\t$birthinterval\n");
	$previousbirth = $line[8];
    } else {
	if ($children >=1) {
	    $parents{$proci} = $children;
	    if ($birthinterval>0) {
		$bi{$proci} = ($children-1)/$birthinterval;
	    } else {
		$bi{$proci} = 0;
	    }
	}
	$birthinterval = 0;
	$previousinterval = 0;
	$previousbirth = $line[8];
	$proci = $line[0];
	$children = 1;
	$info{$proci}{$m} = $line[2];
	$info{$proci}{$d} = $line[4];
	$info{$proci}{$md} = $date[0];
	$info{$proci}{$mbday} = $mom[0];
	$info{$proci}{$dbday} = $dad[0];
	push @{ $childid{$proci} }, $line[6];
	push @{ $bday{$proci} }, $line[8];
	$lastbirth{$proci} = $line[8];
    }
}

$parents{$proci} = $children;
if ($birthinterval>0) {
    $bi{$proci} = ($children-1)/$birthinterval;
} else {
    $bi{$proci} = 0;
}

open (OUT, ">../../results/Updated_interbirthtable_twin_onebirth") || die "nope:$!";
#open (OUT, ">nochildped") || die "nope: $!";
print OUT ("procid\tchildren\tdys_2_lastbirth\tbirth_rate\tmom_byr\tdad_byr\n");


foreach my $id (keys %parents) {
#    print ("$id\t$parents{$id}\t$info{$id}{$m}\t$info{$id}{$d}\t$info{$id}{$md}\t");
    print OUT ("$id\t$parents{$id}\t$lastbirth{$id}\t$bi{$id}\t$info{$id}{$mbday}\t$info{$id}{$dbday}\n");
    my $totalch = $parents{$id};
    for (my $i=0; $i < $totalch; $i++) {
	my $years = ($bday{$id}[$i])/365;
#	print ("$childid{$id}[$i]\t$bday{$id}[$i]\t$years\t");
    }
#    print "\n";
}
