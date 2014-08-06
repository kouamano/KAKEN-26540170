#!/usr/bin/perl

# vars
$help = 0;
$check = 0;
$status = 0;
$hitfile = "";
$resfile = "";
$ie = 0;

# subroutine
sub _help {
	print "USAGE:\n";
	print " count_Res_in_Art.pl [-h] [-c] [-s] hf=<hit file> rf=<resource name file> \n";
	print "DESCRIPTION:\n";
	print " indcies start at 1.\n";
}

sub _check {
	print "ARGS:\n";
	print " help:$help:\n";
	print " check:$check:\n";
	print " status:$status:\n";
	print " hitfile:$hitfile:\n";
	print " resfile:$resfile:\n";
}

sub _status {
	print "STATUS:\n";
	printf " Under construction.\n"
}

# argment analysis
foreach $l (@ARGV) {
	if($l eq "-h"){
		$help = 1;
	}elsif($l eq "-c"){
		$check = 1;
	}elsif($l eq "-s"){
		$status = 1;
	}elsif($l =~ /hf=(.*)/){
		$hitfile = $1;
	}elsif($l =~ /rf=(.*)/){
		$resfile = $1;
	}else{
		print "unknown:$l:\n";
	}
}

# main
if($help == 1){
	&_help;
	$ie = 1;
}
if($check == 1){
	&_check;
	$ie = 1;
}
if($status == 1){
	&_status;
	$ie = 1;
}
if($ie == 1){
	exit(0);
}

## argorithm
### read resfile to hash
@reshash = ();
open(IN,$resfile);
$reshashID = 1;
$sizeRes = 0;
while(<IN>){
	chomp;
	#print uc($_);
	$reshash{uc($_)} = $reshashID;
	$reshashID++;
	$sizeRes++;
}
close(IN);
### read hitfile to arr
open(IN,$hitfile);
while(<IN>){
	push(@arr,$_);
}
close(IN);
$ast = join('',@arr);
@arr = split(";;;\n",$ast);
$sizeArt = @arr;
### print first line (matrix size)
print "$sizeArt\t$sizeRes\t0\n";
### analize arr
@count = ();
foreach(@arr){
	@subarr = split("\n",$_);
	$fname = shift(@subarr);
	$fname =~ s/\[([0-9]+)\]//;
	#print "$1\n";
	$currArtID = $1 + 1;
	#print "$currArtID\n";
	foreach(@subarr){
		$_ =~ s/(^[^\t]+)\t//;
		$currResStr = uc($1);
		$currResID = $reshash{$currResStr};
		$coordline = "$currArtID\t$currResID";
		#print "$coordline\n";
		$count{$coordline}++;
	}
}
### print hash
while(my ($key,$val) = each(%count)){
	print "$key\t$val\n";
}
