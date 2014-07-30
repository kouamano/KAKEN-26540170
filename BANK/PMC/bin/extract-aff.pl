#!/usr/bin/perl
while(<>){
	@hit = $_ =~ /(<aff [^<>]*>.*?<\/aff>)/ig;
	foreach $j (@hit) {
		print "$j\n";
	}
}
