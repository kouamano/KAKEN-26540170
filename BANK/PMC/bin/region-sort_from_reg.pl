#!/usr/bin/perl

while(<>){
	push(@arr,$_);
}
$astr = join('',@arr);
@arr = split(/;;;\n/,$astr);	#regex or string ? ";;;\n"
foreach (@arr) {
	@subarr = ();
	@subarr = split(/\n/,$_);	#regex or string ? "\n"
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
