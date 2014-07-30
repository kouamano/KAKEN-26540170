#!/usr/bin/perl

while(<>){
	chomp;
	$_ =~ s/<aff[^<>]*>//ig;
	$_ =~ s/<\/aff[^<>]*>//ig;
	$_ =~ s/^\s+//;
	$_ =~ s/\s+$//;
	print "$_\n";
}
