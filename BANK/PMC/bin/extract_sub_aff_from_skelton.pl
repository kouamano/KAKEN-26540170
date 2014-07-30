#!/usr/bin/perl

$lv = 0;
$subaff = 0;
while(<>){
	chomp;
	if($_ =~ /^:::<aff>/){
		$subaff = 1;
	}elsif($_ =~ /^:::<[^<>]+/){
		$subaff = 0;
	}elsif($_ =~ /^:{1,2}</){
		$subaff = 0;
	}
	$_ =~ /^(:+)</;
	$lv = length($1);
	if($lv >= 3 && $subaff == 1){
		print "$_\n";
	}
}
