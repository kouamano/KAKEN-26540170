#!/usr/bin/perl

while(<>){
	local $/ = undef;
	my $data = <>;
	$data =~ s/\s+/ /g;
	$data =~ /(<body>.+<\/body>)/i;
	#print "$1\n";
	$data = $1;
	$data =~ s/[,:\.\"]/ /g;
	$data =~ s/\s+/ /g;
	@data = split(' ',$data);
	foreach $t (@data){
		print "$t\n";
	}
}
