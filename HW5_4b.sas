data road;
input additive car mileage;
datalines;
1 2 18
1 3 15
1 4 14
1 5 13
2 1 15
2 2 15
2 4 14
2 5 11
3 1 13
3 3 14
3 4 13
3 5 10
4 1 14
4 2 12
4 3 12
4 4 13
5 1 12
5 2 13
5 3 11
5 5 9
;

options nocenter ps=60 ls=75;
proc glm;
	class car additive;
	model mileage = car additive;
	lsmeans additive / tdiff pdiff adjust=bon stderr;
	lsmeans additive / pdiff adjust=tukey;
	contrast 'c1' additive 2 2 2 -3 -3;
	estimate 'c1' additive 2 2 2 -3 -3;
run;
