#!/usr/bin/perl

while(<>){
	chomp;
	if($_ =~ /^\t\t/){
		@l = split(/\t/,$_);
		#print head
		$url = $l[0];
		$url =~ s/^\s+//;
		$url =~ s/\s+$//;
		$nxml = $l[1];
		$nxml =~ s/^\s+//;
		$nxml =~ s/\s+$//;
		$nxml =~ s/\s+/ /g;
		$id = $l[2];
		$id =~ s/^\s+//;
		$id =~ s/\s+$//;
		print "$url\t$nxml\t$id\t";

		#extract & escape sentence
		$sent = $l[3];
		$sent =~ s/^\s+//;
		$sent =~ s/\s+$//;
		$sent =~ s/\s+/ /g;
		#1 print "$sent\t";

		#uniq res
		$res = $l[4];
		$res =~ s/^\s+//;
		$res =~ s/\s+$//;
		$res =~ s/ ;$//;
		@res = split(" ; ",$res);
		foreach(@res){
			$_ =~ s/^\s+//;
			$_ =~ s/\s+$//;
			$_ =~ s/\\([^\\])/$1/g;
			$_ =~ s/\\\\/\\/g;
			##escape for match
			$_ =~ s/\//\\\//g;
			$_ =~ s/\'/\\\'/g;
			$_ =~ s/\(/\\\(/g;
			$_ =~ s/\)/\\\)/g;
		}
		@resu = &uniq(@res);
		$resu = join(" ; ",@res);
		#2 print "$resu\t";

		#uniq org
		$org = $l[5];
		$org =~ s/^\s+//;
		$org =~ s/\s+$//;
		$org =~ s/ ;$//;
		@org = split(" ; ",$org);
		foreach(@org){
			$_ =~ s/^\s+//;
			$_ =~ s/\s+$//;
			$_ =~ s/\\([^\\])/$1/g;
			$_ =~ s/\\\\/\\/g;
			##escape for match
			$_ =~ s/\//\\\//g;
			$_ =~ s/\'/\\\'/g;
			$_ =~ s/\(/\\\(/g;
			$_ =~ s/\)/\\\)/g;
		}
		@orgu = &uniq(@org);
		$orgu = join(" ; ",@org);
		#3 print "$orgu\t";

		#position/order
		%hpos = ();
		##res positions in sentence
		foreach(@resu){
			while($sent =~ /($_)/gm){
				$s = pos($sent);
				$hpos{$s} = "R";
			}
		}
		##add org positions in sentence
		foreach(@orgu){
			while($sent =~ /($_)/gm){
				$s = pos($sent);
				$hpos{$s} = "O";
			}
		}
		##insert mark
		foreach(@resu){
			$sent =~ s/($_)/<RES>$1<\/RES>/g;
		}
		foreach(@orgu){
			$sent =~ s/($_)/<ORG>$1<\/ORG>/g;
		}
		##print sent, resu, orgu
		print "$sent\t";
		print "$resu\t";
		print "$orgu\t";
		##sort, print pos
		print ":";
		for my $key (sort{$a <=> $b} keys %hpos){
			print $key.$hpos{$key}.":";
		}

		#print tail
		$add = $l[7];
		$add =~ s/^\s+//;
		$add =~ s/\s+$//;
		$qu = $l[8];
		$qu =~ s/^\s+//;
		$qu =~ s/\s+$//;
		print "\t$add\t$qu";

		#print LF
		print "\n";
	}elsif($_ =~ /^\t/){
		$_ =~ s/^\s+//;
		$_ =~ s/\s+$//;
		print "\t$_\n";
	}else{
		$_ =~ s/^\s+//;
		$_ =~ s/\s+$//;
		print "$_\n";
	}
}

sub uniq{
	my @arr = @_;
	my %hash;
	@hash{@arr} = ();
	return keys %hash;
}

