#!/usr/bin/perl

while(<>){
	if($_ =~ /^:[0-9RO]/){
		$_ =~ s/;E//g;
		$_ =~ s/://g;
		$_ =~ s/[0-9]//g;
		print $_;
	}
}
