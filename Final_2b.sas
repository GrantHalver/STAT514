data reaction;
input batch day ingredient time;
datalines;
1 1 1 13
1 2 2 12
1 3 4 6
1 4 3 12
1 5 5 8
2 1 3 16
2 2 5 7
2 3 1 12
2 4 4 8
2 5 2 13
3 1 2 9
3 2 1 14
3 3 3 15
3 4 5 6
3 5 4 10
4 1 4 11
4 2 3 13
4 3 5 11
4 4 2 11
4 5 1 15
5 1 5 9
5 2 4 7
5 3 2 8
5 4 1 13
5 5 3 13
;

proc glm;
	class day ingredient batch;
	model time=ingredient batch day;
	means ingredient/ lines tukey;
	means batch day;
	output out=new1 r=res p=pred;
	symbol1 v=circle;

proc means; var time;

proc gplot; plot res*pred;

proc univariate noprint normal;
	histogram res / normal (L=1 mu=0 sigma=est) kernel (L=2);
	qqplot res/normal (L=1 mu=0 sigma=est);
run;
