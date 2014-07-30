#!/usr/bin/perl

$f = shift(@ARGV);
$argcount = $#ARGV + 1;
$count = 1;
open(IN,$f);
while(<IN>){
	push(@arr,$_);
}
close(IN);
$arr = join('',@arr);
@arr = split(';;;\n',$arr);
foreach(@ARGV){
	print "$arr[$_]";
	print ";;;\n";
}
