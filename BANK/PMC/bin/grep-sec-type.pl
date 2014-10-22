#!/usr/bin/perl

while(<>){
	if($_ =~ /\.\//){
		print $_;
	}elsif($_ =~ /sec-type=/){
		print $_;
	}else{
		;
	}
}
