#!/usr/bin/perl

while(<>){
	chomp;
	$_ =~ s/<\s*([^<>\s]+).*>[^<>]+<\/\1>//ig;
	$_ =~ s/^\s+//;
	$_ =~ s/\s+$//;
	print "$_\n";
}
