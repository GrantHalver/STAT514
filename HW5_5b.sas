data tube;
input temp glass k light;
datalines;
1 1 1 59.5
1 1 2 58.3
1 1 3 58.7
1 2 1 56.5
1 2 2 54.5
1 2 3 59.4
1 3 1 56.1
1 3 2 58.5
1 3 3 61.4
2 1 1 108.5
2 1 2 108.2
2 1 3 108
2 2 1 108.5
2 2 2 105.2
2 2 3 106.5
2 3 1 107.8
2 3 2 108.8
2 3 3 110.1
3 1 1 130.7
3 1 2 129.5
3 1 3 130.3
3 2 1 119.3
3 2 2 117.7
3 2 3 111.1
3 3 1 103.2
3 3 2 106.9
3 3 3 105.4
;

proc glm;
	class temp glass;
	model light = temp glass temp*glass;
	output out=tubenew r=res p=pred;
run;

proc means data=tube; var light; run;
proc means data=tube; var light; by temp; run;

proc sort data=tube;
	by glass temp k;
proc means data=tube; var light; by glass; run;

proc sort data=tube;
	by temp glass k;
proc means data=tube; var light;  by temp glass; run;

proc gplot data=tubenew;
	plot res*pred;

proc univariate noprint normal data=tubenew;
	histogram res / normal (L=1 mu=0 sigma=est) kernel (L=2);
	qqplot res/normal (L=1 mu=0 sigma=est);
run;

data tube1;
input temp glass k light;
temp1 = temp - 125;
temp2 = temp1 * temp1;
datalines;
100 1 1 59.5
100 1 2 58.3
100 1 3 58.7
100 2 1 56.5
100 2 2 54.5
100 2 3 59.4
100 3 1 56.1
100 3 2 58.5
100 3 3 61.4
125 1 1 108.5
125 1 2 108.2
125 1 3 108
125 2 1 108.5
125 2 2 105.2
125 2 3 106.5
125 3 1 107.8
125 3 2 108.8
125 3 3 110.1
150 1 1 130.7
150 1 2 129.5
150 1 3 130.3
150 2 1 119.3
150 2 2 117.7
150 2 3 111.1
150 3 1 103.2
150 3 2 106.9
150 3 3 105.4
;

data tube1;
	set tube1;
	IF glass = 1 THEN glass_1 = 1;
		else glass_1 = 0;
	IF glass = 2 THEN glass_2 = 1;
		else glass_2 = 0;
	IF glass = 3 THEN glass_3 = 1;
		else glass_3 = 0;
run;

proc reg data=tube1;
	where glass_1 = 1;
	model light = temp1 temp2;
run;

proc reg data=tube1;
	where glass_2 = 1;
	model light = temp1 temp2;
run;

proc reg data=tube1;
	where glass_3 = 1;
	model light = temp1 temp2;
run;

proc reg data=tube1;
	model light = temp1 temp2 glass_1 glass_2;
run;
