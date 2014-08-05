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
		print $_;
		if(($_ =~ /.*sec-type=\".*materials.*/i) || ($_ =~ /.*sec-type=\".*methods.*/i)){
			if($INMMS > 0){
				$PrevINMMS = $INMMS;
				$INMMS++;
				$startDetect++;
			}else{
				$PrevINMMS = 0;
				$INMMS = 1;
				$startDetect = 1;
			}
			print "\[$PrevINMMS,$INMMS\]";
		}elsif($_ =~ /.*<sec .*/){
			if($INMMS > 0){
				$PrevINMMS = $INMMS;
				$INMMS++;
			}else{
				$INMMS++;
			}
			print "\[$PrevINMMS,$INMMS\]";
		}elsif($_ =~ /.*:e:.*/){
			if($INMMS > 0){
				$PrevINMMS = $INMMS;
				$INMMS = ($INMMS - 1);
			}else{
				$INMMS = ($INMMS - 1);
			}
			print "\[$PrevINMMS,$INMMS\]";
		}
		print "\n";
		if($PrevINMMS == 0 && $INMMS == 1){
			@tmparr = split('-',$_);
			$startMM = shift(@tmparr);
			$endDetect = 0;
		}
		if($PrevINMMS == 1 && $INMMS == 0 && $endDetect == 0){
			@tmparr = split('-',$_);
			shift(@tmparr);
			$endMM = shift(@tmparr);
			$endMM =~ s/[^0-9]+$//;
			$endDetect++;
			if($startDetect == 1){
				print "region-MMs:$startMM-$endMM\n";
			}else{
				#print "region-MMs:\n";
			}
			$startDetect--;
		}
	}
	print ";;;\n";
}
