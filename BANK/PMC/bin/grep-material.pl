#!/usr/bin/perl

while(<>){
	if($_ =~ /\.\//){
		print $_;
	}elsif($_ =~ /material/){
		print $_;
	}else{
		;
	}
}
