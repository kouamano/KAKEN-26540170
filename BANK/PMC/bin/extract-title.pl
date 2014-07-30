#!/usr/bin/perl
while(<>){
	@hit = $_ =~ /(<article-title>.*?<\/article-title>)/ig;
	foreach $j (@hit) {
		print "$j\n";
	}
}
