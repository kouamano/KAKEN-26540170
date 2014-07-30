#!/usr/bin/perl

@pat=("bio *resource");
$span=".{0,100}";
print "[::\n";
print ":$ARGV[0]:\n";
while(<>){
	foreach $aff (@pat){
		$ex="(".$span.$aff.$span.")";
		@hit = $_ =~ /$ex/ig;
		foreach $j (@hit) {
			print "$j\n";
		}
	}
}
print "::]\n";
