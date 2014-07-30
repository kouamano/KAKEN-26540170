#!/usr/bin/perl

while(<>){
	push(@arr,$_);
}
$tx = join("",@arr);
while($tx =~ /(<sec[^<>]*>)/ig){
	$m = "";
	$p = pos($tx);
	$l = length($1);
	$s = $p-$l;
	$e = $p-1;
	$1 =~ /(sec-type=\"[^\"]\")/ig;
	print "$s-$e:s:$1:\n";
}
print ";;\n";
while($tx =~ /(<\/sec>)/ig){
	$p = pos($tx);
	$l = length($1);
	$s = $p-$l;
	$e = $p-1;
	print "$s-$e:e:\n";
}
print ";;;\n";
