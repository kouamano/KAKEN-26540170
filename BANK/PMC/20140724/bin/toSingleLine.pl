#!/usr/bin/perl

while(<>){
	push(@arr,$_);
}
$total = join('',@arr);
$total =~ s/\n\t\t/\t;;\t/g;
print $total;
