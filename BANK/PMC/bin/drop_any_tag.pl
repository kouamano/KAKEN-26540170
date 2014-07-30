#!/usr/bin/perl

while(<>){
	chomp;
	$_ =~ s/<[^<>]*>//ig;
	$_ =~ s/^\s+//;
	$_ =~ s/\s+$//;
	print "$_\n";
}
