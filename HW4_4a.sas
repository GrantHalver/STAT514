data temperature;
infile 'C:\Users\Grant\Downloads\temperature.dat';
input temp density;

proc glm data=temperature;
	class temp;
	model density=temp;
	estimate 'C1' temp -3 -1 1 3;
	estimate 'C2' temp 1 -1 -1 1;
	estimate 'C3' temp -1 3 -3 1;
	contrast 'C1' temp -3 -1 1 3;
	contrast 'C2' temp 1 -1 -1 1;
	contrast 'C3' temp -1 3 -3 1;
	output out=diag r=res p=pred;
run;

proc means;
	var density;
run;
