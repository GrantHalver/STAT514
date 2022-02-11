data insulin;
infile 'C:\Users\Grant\Downloads\insulin.dat';
input t1 t2 t3;
y=t1; trt=1; output;
y=t2; trt=2; output;
y=t3; trt=3; output;
drop t1 t2 t3;

proc glm;
	class trt;
	model y=trt;
	output out=diag r=res p=pred;
run;

proc sort; by pred;
symbol1 v=circle i=sm50; title1 ’Residual Plot’;

proc gplot;
	plot res*pred/frame;
run;

proc univariate data=diag normal;
	var res;
	qqplot res / normal (L=1 mu=est sigma=est);
	histogram res / normal;
run;

symbol1 v=circle i=none;
title1 ’Plot of residuals vs time’;
proc gplot;
	plot res*time / vref=0 vaxis=-6 to 6 by 1;
run;

proc means data=insulin;
	class trt;
run; quit;
