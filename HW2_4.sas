data defects;
infile 'C:\Users\Grant\Downloads\hw2.dat';
input trt response;
logresp = log(response);

proc glm;
	class trt;
	model response=trt;
	means trt/hovtest=levene;
	output out=diag r=res p=pred;
run;

proc sort; by pred;
symbol1 v=circle i=sm50; title1 ’Residual Plot’;

proc gplot;
	plot res*pred/frame;
run;

 proc univariate data=defects noprint;
 var response; by trt;
 output out=two mean=mu std=sigma;

 data three;
 set two;
 logmu = log(mu);
 logsig = log(sigma);

 proc reg;
 model logsig = logmu;

title1 'Mean vs Std Dev';
symbol1 v=circle i=rl;
proc gplot;
 plot logsig*logmu;
run;

options ls=80 ps=65 nocenter; 
title1 'Box-Cox';

proc univariate noprint;
 var logresp; output out=two mean=mlogresp;

 data three;
 set defects; if _n_ eq 1 then set two;
 ydot = exp(mlogresp);
 do l=-1.0 to 1.0 by .25;
    den = l*ydot**(l-1);   if abs(l) eq 0 then den = 1;
    yl=(response**l -1)/den;   if abs(l) < 0.0001 then yl=ydot*log(response);
    output; 
 end;
 keep trt yl l;

proc sort data=three out=three;  by l;
proc glm data=three noprint outstat=four;
 class trt;  model yl=trt;  by l; 

data five;  set four;
 if _SOURCE_ eq 'ERROR';  keep l SS;

proc print data=five;
run;

symbol1 v=circle i=sm50;
proc gplot;
 plot SS*l;
run;

proc glm data = defects;
	class trt;
	model logresp=trt;
	means trt/hovtest=levene;
	output out=diag r=res p=pred;
run;

proc sort; by pred;
symbol1 v=circle i=sm50; title1 ’Residual Plot’;

proc gplot;
	plot res*pred/frame;
run;
