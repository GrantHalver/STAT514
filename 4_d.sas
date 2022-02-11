data oven;
input temp oven strength;
datalines;
1 1 3.5
1 2 10.5
1 3 4.5
1 4 7.5
1 5 3.5
2 1 4.5
2 2 8.5
2 3 2.5
2 4 12.5
2 5 3.5
3 1 10.5
3 2 13.5
3 3 3.5
3 4 15.5
3 5 9.5
4 1 13.5
4 2 12.5
4 3 8.5
4 4 9.5
4 5 7.5
;

proc glm;
	class temp oven;
	model strength = temp oven;
	means temp / alpha=0.01 tukey lines;
	output out=diag r=res p=pred;

proc univariate noprint normal;
	qqplot res / normal (L=1 mu=0 sigma=est);
	histogram res /normal (L=1 mu=0 sigma=est) kernel(L=2 K=quadratic);
run;

proc gplot;
	plot res*temp / haxis=axis1;
	plot res*oven / haxis=axis1;
	plot res*pred;
run;

data diag;
	set diag;
	q = pred*pred;

proc glm data = diag;
	class temp oven;
	model strength = temp oven q/ss3;
run;
