#!/usr/bin/perl

while(<>){
	$_ =~ s/<sup>.+<\/sup>//ig;
	#$_ =~ s/<label>.+<\/label>//ig;
	print $_;
}
