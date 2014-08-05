#!/usr/bin/perl

# vars
$help = 0;
$check = 0;
$status = 0;
$res = 0;
$sec = "";
$ie = 0;

# subroutine
sub _help {
	print "USAGE:\n";
	printf " check_res_in_MMs.pl res=<file of resorce name search result> sec=<file of sec element position>\n"
}

sub _check {
	print "ARGS:\n";
	print " help:$help:\n";
	print " check:$check:\n";
	print " status:$status:\n";
	print " res:$res:\n";
	print " sec:$sec:\n";
}

sub _status {
	print "STATUS:\n";
	printf " available.\n"
}

# argment analysis
foreach $l (@ARGV) {
	if($l eq "-h"){
		$help = 1;
	}elsif($l eq "-c"){
		$check = 1;
	}elsif($l eq "-s"){
		$status = 1;
	}elsif($l =~ /res=(.*)/){
		$res = $1;
	}elsif($l =~ /sec=(.*)/){
		$sec = $1;
	}else{
		print "unknown:$l:\n";
	}
}

# main
if($help == 1){
	&_help;
	$ie = 1;
}
if($check == 1){
	&_check;
	$ie = 1;
}
if($status == 1){
	&_status;
	$ie = 1;
}
if($ie == 1){
	exit(0);
}

## read res
open(IN,$res);
while(<IN>){
	push(@rrr,$_);
}
close(IN);
$lres = join("",@rrr);
@rrr = split(";;;\n",$lres);
$k = 0;
foreach (@rrr) {
	$_ =~ s/(^\.\/.*?nxml)\n//;
	push(@resfile_arr,$1);
	push(@resname_arr,$_);
	$k++;
}
$num_resfile = $k;

## read sec and analyze
open(IN,$sec);
while(<IN>){
	push(@srr,$_);
}
close(IN);
$lsec = join("",@srr);
@srr = split(';;;\n',$lsec);
$i = 0;
foreach (@srr) {
	print "[sec-MMs][$i]";
	### analyse sub 
	@srrr = split("\n",$_);
	$lensrrr = @srrr;
	$secfile = shift(@srrr);
	print "$secfile;\n";
	@srrr = sort {$a <=> $b} @srrr;
	shift(@srrr);
	$IN_MMs = 0;
	foreach (@srrr) {
		if(($_ =~ /method/i) || ($_ =~ /material/i)){
			$_ =~ /^[0-9]+-([0-9]+)/;
			$start_pos = ($1)+1;
			$IN_MMs = 1;
		}elsif($_ =~ /:s:</){
			if($IN_MMs > 0){
				$IN_MMs++;
			}else{
				$IN_MMs--;
			}
		}elsif($_ =~ /:e:$/){
			$IN_MMs--;
		}
		#print "IN:$IN_MMs:\n";
		if($IN_MMs == 0){
			$_ =~ /(^[0-9]+)-[0-9]+/;
			$end_pos = ($1)-1;
			#print " end_pos:$end_pos:\n";
			if(($end_pos - $start_pos) > 0){
				if($secfile eq $resfile_arr[$i]){
					#print " [$i]$resfile_arr[$i];\n";
					#check resource
					#print "$resname_arr[$i]";
					@resname_tmp_sub_arr = split("\n",$resname_arr[$i]);
					#print "$resname_tmp_sub_arr[0]\n";
					foreach(@resname_tmp_sub_arr){
						($Rname,$S,$E) = split("\t",$_);
						#print "$Rname\n";
						#print "start:$start_pos: < S:$S: < E:$E: < end:$end_pos:\n";
						if(($start_pos < $S) && ($E < $end_pos)){
							#print "HIT:::";
							print "$Rname\t$S\t$E";
							print "\tin\t$start_pos\t$end_pos\n";
						}

					}
				}else{
					print "  !!WARNIG!! do not match file name.\n"
				}
			}else{
				print "No span.\n"
			}
		}
	}
	$i++;
	print ";;;\n";
}

