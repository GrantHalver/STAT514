options nocenter ps=60 ls=75;

data experiment;
input trt block resp @@;
datalines;
1 1 12
1 2 15
1 3 18
2 1 14
2 3 16
2 4 12
3 1 16
3 2 20
3 4 18
4 2 25
4 3 14
4 4 12
;

proc glm;
	class block trt;
	model resp = block trt;
	lsmeans trt / tdiff pdiff adjust=bon stderr;
	lsmeans trt / pdiff adjust=tukey;
	lsmeans block;
	contrast 'a' trt 1 -1 0 0;
	estimate 'b' trt 0 0 1 -1;
run;

proc means; var resp; run;
