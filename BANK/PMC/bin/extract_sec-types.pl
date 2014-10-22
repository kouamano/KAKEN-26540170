#!/usr/bin/perl

while(<>){
	if($_ =~ /(sec-type="[^"]*")/){
		print "$1\n";
	}
}
