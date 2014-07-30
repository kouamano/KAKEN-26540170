#!/usr/bin/perl
while(<>){
	$_ =~ s/<[^<^>]+>?/ /ig;
	$_ =~ s/<\/[^<^>]+>?/ /ig;
	#$_ =~ s/^<article-title>//i;
	#$_ =~ s/<\/article-title>$//i;
	print $_;
}
