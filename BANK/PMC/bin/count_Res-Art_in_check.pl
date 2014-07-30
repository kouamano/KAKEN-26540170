#!/usr/bin/perl

# vars
$help = 0;
$check = 0;
$status = 0;
$cf = "";
$rf = "";
$ie = 0;

# subroutine
sub _help {
	print "USAGE:\n";
	printf " count_Res-Art_in_check.pl -h -c -s -U cf=<check file> rf=<resource name file>\n";
	print "  -h : help.\n";
	print "  -c : check args.\n";
	print "  -s : print status.\n";
	print "  -U : upper ignore.\n";
	print "  <check file> : output from check_res_sec-MMs.pl\n";
	print "  <resource name file> : resource list.\n";
}

sub _check {
	print "ARGS:\n";
	print " help:$help:\n";
	print " check:$check:\n";
	print " status:$status:\n";
	print " upper:$upper:\n";
	print " cf:$cf:\n";
	print " rf:$rf:\n";
}

sub _status {
	print "STATUS:\n";
	printf " under construction.\n";
}

# argment analysis
foreach $l (@ARGV) {
	if($l eq "-h"){
		$help = 1;
	}elsif($l eq "-c"){
		$check = 1;
	}elsif($l eq "-s"){
		$status = 1;
	}elsif($l eq "-U"){
		$upper = 1;
	}elsif($l =~ /cf=(.*)/){
		$cf = $1;
	}elsif($l =~ /rf=(.*)/){
		$rf = $1;
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

## read rf
@rn_arr = ();
open(IN,$rf);
while(<IN>){
	chomp;
	if ($upper == 1) {
		push(@rn_arr,uc($_));
	}else{
		push(@rn_arr,$_);
	}
}
close(IN);

## read cf
#print $count{'res'};
print "<Journal_vs_Resouce_count_matrix>";
foreach(@rn_arr){
	print "\t$_";
}
print "\n";
%count = ();
open(IN,$cf);
while(<IN>){
	chomp;
	if($_ =~ /^\[.*nxml;$/){
		print $_;
		%count = ();
		foreach $rn (@rn_arr) {
			$count{$rn} = 0;
		}
	}elsif($_ eq ';;;'){
		foreach $rn (@rn_arr){
			print "\t$count{$rn}";
		}
		print "\n";
	}else{
		if ($upper == 1) {
			@tmp = split("\t",uc($_));
		}else{
			@tmp = split("\t",$_);
		}
		$name = shift(@tmp);
		$count{$name}++;
	}
}
close(IN);
