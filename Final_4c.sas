data anode;
input temp position density;
datalines;
1 1 580
1 1 590
1 1 585
1 2 530
1 2 535
1 2 540
2 1 600
2 1 610
2 1 595
2 2 560
2 2 540
2 2 535
3 1 590
3 1 585
3 1 590
3 2 520
3 2 525
3 2 530
;

proc glm;
	class temp position;
	model density=temp position temp*position;
	means temp;
	means position;
	output out=anodenew r=res p=pred;
run;

proc means data = anode; var density; run;
proc means data= anode; var density; by temp position; run;

data anode1;
input temp position density;
t = (temp-825)/25;
t2 = t*t;
datalines;
800 1 580
800 1 590
800 1 585
800 2 530
800 2 535
800 2 540
825 1 600
825 1 610
825 1 595
825 2 560
825 2 540
825 2 535
850 1 590
850 1 585
850 1 590
850 2 520
850 2 525
850 2 530
;

proc reg;
	where position = 1;
	model density = t t2;
run;

proc reg;
	where position = 2;
	model density = t t2;
run;

proc glm data = anode;
	class temp position;
	model density = position|temp;
run;

data results;
	pbetaL = cinv(1-0.025,1.569853556);
	pbetaU = cinv(0.025,1.569853556);
	ptaubetaL = cinv(1-0.025,0.0785957606);
	ptaubetaU = cinv(0.025,0.0785957606);
	betaL = 1.569853556*68.98148167/pbetaL;
	beatU = 1.569853556*68.98148167/pbetaU;
	taubetaL = 0.0785957606*4.62963/ptaubetaL;
	taubetaU = 0.0785957606*4.62963/ptaubetaU;
proc print; run;
