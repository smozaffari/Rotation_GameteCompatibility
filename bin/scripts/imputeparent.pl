#!/usr/bin/perl

use strict;
use warnings;

my %proci;
my %rs520;
my %rs573;
my %child;
my %mom;
my %dad;
my %grandma;
my %grandpa;

#out.csv in data/files_from_William
open (FILE, "/group/ober-resources/users/smozaffari/GameteCompatibility/data/files_from_William/out.csv") || die "nope: $!";
while (my $line = <FILE>) {
    chomp $line;
    my @line = split(",", $line);
    if ($line[3]) { # have a procreation/marriage id #
	if ($line[0] =~ /1$/) { # if it's a male
	    $proci{$line[3]}[0] = $line[0];
#	    $rs573{$line[0]}= $line[6]; #assign it the male snp
	} else { # it it's not a male = female
	    $proci{$line[3]}[1] = $line[0];
#     	    $rs520{$line[0]}= $line[8]; #assign it the female snp
	}
    }
    push @{ $child{$line[4]}}, $line[0];
    $mom{$line[0]} = $line[1];
    $dad{$line[0]} = $line[2];
    $rs520{$line[0]} = $line[8];
    $rs573{$line[0]} = $line[6];
}
close(FILE);

foreach my $id ( keys %proci ) {
#    print "$id: $proci{$id}[0]\t$proci{$id}[1]\n ";
#C = Threonine = ancestral
#T = Isoleucine = alternate
    if ($proci{$id}[0] && $proci{$id}[1]) {
	my $male = $proci{$id}[0];
	my $female = $proci{$id}[1];
#	print "$male\t$female\t";
#	print "$rs573{$male}\t$rs520{$female}";
	if ($rs573{$male} =~ /CC/) {
	    if ($rs520{$female} =~ /AA/) {
		$proci{$id}[2] = "Thr/Val";
	    } elsif ($rs520{$female} =~ /CC/) {
		$proci{$id}[2] = "Thr/Gly";
	    } else {
		$proci{$id}[2] = "Thr/Het";
	    }
	} elsif ($rs573{$male} =~ /TT/) {
	    if ($rs520{$female} =~ /AA/) {
		$proci{$id}[2] = "Ile/Val";
	    } elsif ($rs520{$female} =~ /CC/) {
		$proci{$id}[2] = "Ile/Gly";
	    } else {
		$proci{$id}[2] = "Ile/Het";
	    }
	} else {
	    if ($rs520{$female} =~ /AA/) {
		$proci{$id}[2] = "Het/Val";
	    } elsif ($rs520{$female} =~ /CC/){
		$proci{$id}[2] = "Het/Gly";
	    } else {
		$proci{$id}[2] = "Het/Het";
	    }
	}
    } else { #if other parent is missing
#	print "$id:\t";
#	if ($proci{$id}[0]) {
#	    my $d = $proci{$id}[0];
#	    print "$d\t$rs520{$d}\t$rs573{$d}\t";
#	} elsif { ($proci{$id}[1]) 
#	    my $m = $proci{$id}[1];
#	    print "$m\t$rs520{$m}\t$rs573{$m}\t";
#	}
	#determine from kids
	if ($child{$id}) {
	    print ("$id:\t");
	    foreach my $i (0..$#{ $child{$id} } ) {
		my $kidsid = $child{$id}[$i];
		print "$kidsid\t";
#		print "$kidsid\t$rs520{$kidsid}\t$rs573{$kidsid}\t";
	    }
	    print "\n";
	}
	#determine from parents?
    }
    if ($proci{$id}[2]) {
	my $male = $proci{$id}[0];
	my $female = $proci{$id}[1];
	print "$id: @{ $proci{$id} }\t$rs573{$male}\t$rs520{$female}\n";
    }
}
