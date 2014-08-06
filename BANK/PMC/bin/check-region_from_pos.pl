#!/usr/bin/perl

# vars
$help = 0;
$check = 0;
$status = 0;
$tf = "";
$rf = "";
$ie = 0;

# subroutine
sub _help {
	print "USAGE:\n";
	printf " check-region_from_pos.pl tf=<target> rf=<region> [-h]\n"
}

sub _check {
	print "ARGS:\n";
	print " help:$help:\n";
	print " check:$check:\n";
	print " status:$status:\n";
	print " tf:$tf:\n";
	print " rf:$rf:\n";
}

sub _status {
	print "STATUS:\n";
	printf " Under construction.\n"
}

# argment analysis
foreach $l (@ARGV) {
	if($l eq "-h"){
		$help = 1;
	}elsif($l eq "-c"){
		$check = 1;
	}elsif($l eq "-s"){
		$status = 1;
	}elsif($l =~ /tf=(.*)/){
		$tf = $1;
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

## argorithm
### read region file
@arr = ();
open(IN,$rf);
while(<IN>){
	push(@arr,$_);
}
close(IN);
### make region array
@regionarr = ();
$ast = join('',@arr);
@arr = split(";;;\n",$ast);
foreach(@arr){
	$_ =~ s/^[^\n]+\n//;
	push(@regionarr,$_);
}
### read target file
@arr = ();
open(IN,$tf);
while(<IN>){
	push(@arr,$_);
}
close(IN);
$ast = join('',@arr);
@arr = split(";;;\n",$ast);
### check
$i = 0;
foreach(@arr){
	@subarr = split("\n",$_);
	$fname = shift(@subarr);
	print "[$i]$fname\n";
	#print "$regionarr[$i]";
	@subregionarr = split("\n",$regionarr[$i]);
	#print "$subregionarr[0]\n";
	#### check each positions to regions(@subregionarr)
	foreach(@subarr){
		$targetline = $_;
		#print "\t$targetline\t{";
		foreach(@subregionarr){
			$_ =~ s/region-MMs://;
			#print "$_ or ";
			($regionstart,$regionend) = split('-',$_);
			#print $regionend;
			#chomp($targetline);
			($targethead,$targetstart,$targetend) = split("\t",$targetline);
			#print " $targetend";
			#print "$regionstart < $targetstart && $regionend > $targetend";
			if(($regionstart < $targetstart) && ($regionend > $targetend)){
				print "$targetline\n";
				break;
			}
		}
		#print "}\n";
	}
	$i++;
	print ";;;\n";
}
