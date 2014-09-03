#!/usr/bin/perl

while(<>){
	push(@arr,$_);
}
$astr = join('',@arr);
@arr = split(/;;;\n/,$astr);
foreach (@arr) {
	@subarr = ();
	@subarr = split(/\n/,$_);
	$fname = shift(@subarr);
	@subsubarr = ();
	foreach (@subarr) {
		if($_ =~ /^[0-9]+\-[0-9]+/){
			push(@subsubarr,"$_\n");
		}
	}
	@srtarr = sort {$a <=> $b} @subsubarr;
	print "$fname\n";
	print @srtarr;
	print ";;;\n";
}
