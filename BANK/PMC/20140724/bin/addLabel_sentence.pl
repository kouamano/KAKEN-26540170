#!/usr/bin/perl

$lc = 0;
while(<>){
	if($lc == 0){
		print "Label\t".$_;
	}else{
		if($_ =~ /^http:/){
			$line = $_;
			if($line =~ /(ACK)\.tsv/){
				#$line =~ /(ACK)\.tsv/;
				$label = $1;
			}elsif($line =~ /from_(Mat)/){
				#$line =~ /from_(Mat)/;
				$label = $1;
			}else{
				$label = "None";
			}
			print $label."\t".$_;
		}else{
			print $label."\t".$_;
		}
	}
	$lc++;
}
