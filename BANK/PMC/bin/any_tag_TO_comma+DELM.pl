#!/usr/bin/perl

$count = 0;
while(<>){
	chomp;
	print "<<$count>>\n";
	$_ =~ s/<[^<>]*>/,/ig;
	$_ =~ s/^\s+//;
	$_ =~ s/\s+$//;
	print "$_\n";
	$count++;
}
