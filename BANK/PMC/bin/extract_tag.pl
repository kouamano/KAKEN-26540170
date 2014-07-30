#!/usr/bin/perl

while(<>){
	chomp;
	#$_ =~ /<\s*([^<>\s]+).*>.*<\/($1).*>/ig;
	$_ =~ /<\/*\s*([^<>\s]+).*>/ig;
	print "$1\n";
}
