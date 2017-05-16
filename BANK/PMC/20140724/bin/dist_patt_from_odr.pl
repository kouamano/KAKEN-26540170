#!/usr/bin/perl

while(<>){
	chomp;
	@line = split("\t",$_);
	$patt = $line[3];
	$patt =~ s/[0-9]//g;
	$patt =~ s/://g;
	$ORGstr = $line[2];
	@ORG = split(" ; ",$ORGstr);
	$RESstr = $line[1];
	@RES = split(" ; ",$RESstr);
	print "$patt\t";
	if($patt =~ /ROR/){
		print "<RES[1]/><ORG/>";
		print "$ORG[0]<;/>$RES[0]"
	}elsif($patt =~ /^OR+/){
		print "<ORG/><x/><RES/>";
		foreach $res (@RES){
			print "$ORG[0]<;/>$res<|/>";
		}
	}elsif($patt =~ /R+O$/){
		print "<ORG/><x/><RES/>";
		foreach $res (@RES){
			print "$ORG[0]<;/>$res<|/>";
		}
	}elsif($patt =~ /^OO+R$/){
			print "<ORG[-1]/><RES/>";
			print "$ORG[$#ORG]<;/>$RES[0]";
	}elsif($patt =~ /^ROO+$/){
			print "<RES/><ORG[1]/>";
			print "$ORG[0]<;/>$RES[0]";
	}elsif($patt =~ /^(R+)(O+)$/){
		$lenR = length($1);
		$lenO = length($2);
		if($lenR == $lenO){
			print "<ORG/><RES/><.../>";
			for ($i=0; $i < $lenR; $i++) {
				print "$ORG[$i]<;/>$RES[$i]<|/>";
			}
		}
	}elsif($patt =~ /^(O+)(R+)$/){
		$lenR = length($1);
		$lenO = length($2);
		if($lenR == $lenO){
			print "<ORG/><RES/><.../>";
			for ($i=0; $i < $lenR; $i++) {
				print "$ORG[$i]<;/>$RES[$i]<|/>";
			}
		}
	}
	print "\n";
}
