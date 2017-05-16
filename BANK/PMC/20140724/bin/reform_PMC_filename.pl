#!/usr/bin/perl

while(<>){
	if($_ =~ /\//){
		$_ =~ s/^.+\/([^\/]+\/[^\/]+)$//;
		print "/BANK/PMC/20140724/articles/$1";
	}else{
		print $_;
	}

}
