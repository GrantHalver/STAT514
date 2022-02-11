data power;
input a N lambda2 F0;
power = 1-probf(F0/lambda2,a-1,N-a);
datalines;
5 20 60.1071 3.06
;

proc print data=power; run;

options nocenter ps=35 ls=72;
data params;
	input a alpha vart var;
	ratiovar = vart/var;
	cards;
	5 .05 75.6083 5.1167
;

data new;
	set params;
	do n=2 to 15;df = a*(n-1);
	lambdasq = 1+ratiovar*n;
	fcut  = finv(1-alpha,a-1,df);
	beta=probf(fcut/lambdasq,a-1,df);
	power=1-beta;
output;end;

proc print;var n beta power;run;
