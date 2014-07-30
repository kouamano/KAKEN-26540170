#!/usr/bin/perl
while(<>){
	$_ =~ s/^<article-title>//i;
	$_ =~ s/<\/article-title>$//i;
	print $_;
}
