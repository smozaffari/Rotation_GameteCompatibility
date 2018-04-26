#!/usr/bin/perl

use strict;
use warnings;

my %proci;
my %rs520;
my %rs573;


open (FILE, "/group/ober-resources/users/smozaffari/GameteCompatibility/data/files_from_William/out.csv") || die "nope: $!";
while (my $line = <FILE>) {
    chomp $line;
    my @line = split(",", $line);
    if ($line[3]) { # have a procreation/marriage id #
	if ($line[0] =~ /1$/) { # if it's a male
	    $proci{$line[3]}[0] = $line[0];
	    $rs573{$line[0]}= $line[6]; #assign it the male snp
	} else { # it it's not a male = female
	    $proci{$line[3]}[1] = $line[0];
     	    $rs520{$line[0]}= $line[8]; #assign it the female snp
	}
    }
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
    } else {
#	print "$id\n";
    }
    if ($proci{$id}[2]) {
	my $male = $proci{$id}[0];
	my $female = $proci{$id}[1];
	print "$id: @{ $proci{$id} }\t$rs573{$male}\t$rs520{$female}\n";
    }
}
