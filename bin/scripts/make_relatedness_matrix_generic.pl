#!/usr/bin/perl
use strict;
use warnings;

#######################################################
#  KI 08/2014
# This scrip requires 3 arguments on the command line:
# 1. kinship file -> indv1 indv2 0.123123 (header)
# 2. subject order file -> one ID per row (no header)
# 3. Output path/filename
######################################################

my $file1=$ARGV[0]; #this is your pairwise kinship file (with header)
my $indiv_orderfile=$ARGV[1]; # this is an input file, one ID per line of the order of the kinship matrix
my $outfile=$ARGV[2]; #name of output file

open (OUT, ">$outfile") or die "Cannot open output file\n";


#######################################################
#  GENERATE KINSHIP DICTIONARY
#######################################################

open(IN,$file1) || die "can't read $file1\n"; 

my $findiv_combinations;
<IN>;
while (my $line = <IN>)
{
	next if $.==1; # use this line if header on pairwise kinship file
	chomp $line;
	my @data = split /\t/, $line;
	$findiv_combinations->{$data[0]."_".$data[1]}=$data[2];
	$findiv_combinations->{$data[1]."_".$data[0]}=$data[2];
	}
close IN;

#######################################################
#  DEFINE ORDER OF INDIVIDUALS FOR MATRIX
######################################################

open(IN2,$indiv_orderfile) || die "can't read $indiv_orderfile\n";
my @findiv;
<IN2>;
while (my $line = <IN2>)
{
	chomp $line;
	my @data = split /\t/, $line;
	push(@findiv, $data[0]);
	}
close IN2;
	
############################################################
#   PRINT OUT MATRIX TO FILE AND MISSING VALUES TO SCREEN
############################################################	
	
foreach (my $findiv1=0; $findiv1<scalar(@findiv);$findiv1++){
	foreach (my $findiv2=0; $findiv2<scalar(@findiv);$findiv2++){ 
		if (defined $findiv_combinations->{$findiv[$findiv1]."_".$findiv[$findiv2]}){
			print OUT $findiv_combinations->{$findiv[$findiv1]."_".$findiv[$findiv2]};
			print OUT "\t";
		}
		else {
			print OUT "NA";
			print $findiv[$findiv1]."_".$findiv[$findiv2]; # this step prints out to bash missing pairwise kinships values
			print "\n";
			print OUT "\t";
		}	
	}
	print OUT "\n";
	}
close OUT;
	