#!/usr/bin/perl

use strict;
use warnings;
use Time::Local;


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
my %momsage; #moms age at marriage : to be used as covariate in calculating birth rate residuals.

open (CHD, "../../results/nochild_data") || die "nope: $! ";
#open (CHD, "out_no-children.tsv") || die "nope: $!";

while (my $line = <CHD>) {
    chomp $line;
    my @line = split("\t", $line);
    my @date = split("-", $line[1]);
    my @mom = split("-", $line[3]);
    my @dad = split("-", $line[5]);
=head
    if ($proci == $line[0]) {
	$children++;
	push @{ $childid{$proci} }, $line[6];
	push @{ $bday{$proci} }, $line[8];
#	$previousinterval = $line[8]-$previousbirth;
#	if ($previousinterval == 0) {
#	    $children = $children-1;
#	}
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
=cut
	$birthinterval = 0;
	$previousinterval = 0;
	$previousbirth = $line[8];
	$proci = $line[0];
	$children = 0;
	$info{$proci}{$m} = $line[2];
	$info{$proci}{$d} = $line[4];
	$info{$proci}{$md} = $date[0];
	$info{$proci}{$mbday} = $mom[0];
	$info{$proci}{$dbday} = $dad[0];
	push @{ $childid{$proci} }, $line[6];
	push @{ $bday{$proci} }, $line[8];
	$lastbirth{$proci} = 0;
    $bi{$proci} = 0;
    $parents{$proci} = 0;
=head
	my $start = "$line[3] 00:00:00";
	my $stop  = "$line[1] 00:00:00";
	my $diff  = str2time($stop) - str2time($start);
	$momsage{$proci} = ($diff*60*60*24);
	print ("$diff\t$momsage{$proci}\n");

=cut
    my $startdat = "$line[3] 00:00:00";
    my $stopdate = "$line[1] 00:00:00";
    print ("$startdat\t$stopdate\t");
    
    my ($years, $months, $days, $hours, $mins, $secs) = split /\W+/, $startdat;
    my ($yeart, $montht, $dayt, $hourt, $mint, $sect) = split /\W+/, $stopdate;
    
    my $times = timelocal($secs,$mins,$hours,$days,$months-1,$years);
    my $timet = timelocal($sect,$mint,$hourt,$dayt,$montht-1,$yeart);
    my $time = $timet - $times;
    
    print "$proci\t$startdat\t$stopdate\t$times\t$timet\t$time\t";
    
    $momsage{$proci} = ($time/(3600*24));
    print ("$momsage{$proci}\t", $momsage{$proci}/365,"\n");


}

$parents{$proci} = $children;
if ($birthinterval>0) {
    $bi{$proci} = ($children-1)/$birthinterval;
} else {
    $bi{$proci} = 0;
}


#open (OUT, ">../../results/Updatedtable_momsage") || die "nope:$!";
open (OUT, ">nochild_momsage") || die "nope: $!";
print OUT ("procid\tchildren\tdys_2_lastbirth\tbirth_rate\tmom_byr\tdad_byr\tmageatmarrdays\n");


foreach my $id (keys %parents) {
#    print ("$id\t$parents{$id}\t$info{$id}{$m}\t$info{$id}{$d}\t$info{$id}{$md}\t");
    print OUT ("$id\t$parents{$id}\t$lastbirth{$id}\t$bi{$id}\t$info{$id}{$mbday}\t$info{$id}{$dbday}\t$momsage{$id}\n");
    my $totalch = $parents{$id};
    for (my $i=0; $i < $totalch; $i++) {
	my $years = ($bday{$id}[$i])/365;
#	print ("$childid{$id}[$i]\t$bday{$id}[$i]\t$years\t");
    }
#    print "\n";
}
