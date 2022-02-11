data stomata;
infile 'C:\Users\Grant\Downloads\stomata.dat';
input needle stomata;

proc glm;
	class needle;
	model stomata=needle;
	output out=diag r=res p=pred;
run;

proc means; var stomata; run;
