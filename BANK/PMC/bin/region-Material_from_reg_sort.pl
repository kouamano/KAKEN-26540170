#!/usr/bin/perl

while(<>){
	push(@arr,$_);
}
$astr = join('',@arr);
@arr = split(";;;\n",$astr);
foreach (@arr) {
	@subarr = split("\n",$_);
	$fname = shift(@subarr);
	print "$fname\n";
	$numlines = @subarr;
	$INMMS = 0;
	$PrevINMMS = -1;
	$startDetect = 0;
	$endDetect = 0;
	$startMM = 0;
	$endMM = 0;
	foreach (@subarr) {
		#print $_;
		#if((($_ =~ /.*sec-type=\".*material.*/i) || ($_ =~ /.*sec-type=\".*method.*/i)) && ($INMMS == 0)){
		if(( ($_ =~ /.*sec-type=\".*material.*/i) ) && ($INMMS == 0)){
			$INMMS = 1;
			#print $_;
			@tmp = split("-",$_);
			print "region-MMs:$tmp[0]-";
			#print "\[$INMMS\] START\n";
		}elsif(($_ =~ /.*<sec.*/) && ($INMMS > 0)){
			$INMMS++;
			#print "\[$INMMS\]";
		}elsif(($_ =~ /.*:e:.*/) && ($INMMS == 1)){
			$INMMS--;
			#print $_;
			@tmp=split(/[-:]/,$_);
			print "$tmp[1]\n";
			#print "\[$INMMS\] END\n";
		}elsif(($_ =~ /.*:e:.*/) && ($INMMS > 1)){
			$INMMS--;
			#print "\[$INMMS\]";
		}
	}
	print ";;;\n";
}
