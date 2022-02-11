data defects;
infile 'C:\Users\Grant\Downloads\defects.dat';
input design defect;

proc glm;
	class design;
	model defect=design;
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

proc npar1way;
	class design;
	var defect;
run;
