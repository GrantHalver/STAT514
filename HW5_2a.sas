data assembly;
input order operator assembly time;
datalines;
1 1 3 10
1 2 2 9
1 3 4 13
1 4 1 7
2 1 2 7
2 2 3 11
2 3 1 9
2 4 4 11
3 1 1 9
3 2 4 10
3 3 2 6
3 4 3 14
4 1 4 8
4 2 1 7
4 3 3 17
4 4 2 6
;

option nocenter ls=75;goptions colors=(none);
proc glm;
	class operator assembly order;
	model time = assembly order operator;
	means assembly / lines tukey alpha=0.1;
	means order operator;
	output out=new1 r=res p=pred;
run;

proc means; var time; run;

symbol1 v=circle;

proc gplot data=new1;
	plot res*pred;

proc univariate noprint normal data=new1;
	histogram res / normal (L=1 mu=0 sigma=est) kernel (L=2);
	qqplot res/normal (L=1 mu=0 sigma=est);
run;
