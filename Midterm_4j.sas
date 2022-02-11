data one;
	fcut = finv(.95,4,15);
	beta = probf(fcut,4,15,240.430);
	power = 1-beta;
proc print data = one; run; quit;

data two;
	df = 4*1;
	fcut = finv(.95,4,df);
	beta = probf(fcut,4,df,240.430);
	power = 1-beta;
proc print data = two; run; quit;
