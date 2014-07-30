#!/usr/bin/perl

sub unique_slice{
    my @array = @_;
    my %hash;
    @hash{@array} = ();
    return keys %hash;
};

while(<>){
	push(@arr,$_);
}
$arr = join('',@arr);
@arr = split(';;;\n',$arr);

foreach(@arr){
	@tmparr = split('\n',$_);
	$fname = shift(@tmparr);
	foreach(@tmparr){
		@tmptmparr = split('\t',$_);
		push(@out,$tmptmparr[0])
	}
	print $fname;
	@out = &unique_slice(@out);
	foreach(@out){print "\t$_"}
	print "\n";
}
