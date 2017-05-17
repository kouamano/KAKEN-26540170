#!/usr/bin/perl

while(<>){
	$_ =~ s/<aff>//g;
	$_ =~ s/<aff [^<>]+>//g;
	$_ =~ s/<\/aff>//g;
	$_ =~ s/<label>[0-9a-zA-Z &#;\*]+<\/label>//g;
	$_ =~ s/<label\/>//g;
	$_ =~ s/<sup>[0-9a-zA-Z]+<\/sup>//g;
	$_ =~ s/<email>[^<>]+<\/email>//g;
	$_ =~ s/<[^<>]+>//g;
	print $_;
}
