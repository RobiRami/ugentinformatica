#n
1{
	s/^1/%1/
}

3{
	s/Su/Sun/;s/Mo/Mon/;
	s/Tu/Tue/;s/We/Wed/;
	s/Th/Thu/;s/Fr/Fri/;
	s/Sa/Sat/
}

4{
	s/1/%1/
}

H

${
	x
	s/^\n//
	:subs
	s/%\([0-9].*\)\(.\)\(.*\)%\([^0-9]*\1\)\( *\)/%\3\4\2\5%/
	t subs
	s/^%[^\n]*\n//
	s/%.*//
	s/^./    &/
	p
}
