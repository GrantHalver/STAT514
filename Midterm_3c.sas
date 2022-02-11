data strength;
input chemical bolt strength;
datalines;
1 1 73
1 2 68
2 1 73
2 2 67
3 1 75
3 2 69
;

proc multtest inpvalues(strength)=strength;
	id chemical;
run;

proc glm;
	class chemical bolt;
	model strength=chemical bolt;
	random bolt;
	output out=diag r=res p=pred;

proc plot;
	plot res*pred;
proc varcomp method = type1;
	class chemical bolt;
	model strength=chemical bolt;

proc mixed cl;
	class chemical bolt;
	model strength = chemical;
	random bolt;
run; quit;

data a1;
	allpem(strength);
run;
