data a1;
input karlsruhe lehigh;
diff = karlsruhe - lehigh - 0.2;
diff2 = diff * diff;
datalines;
1.180 1.061
1.151 0.992
1.322 1.063
1.339 1.062
1.200 1.065
1.402 1.178
1.365 1.037
1.537 1.086
1.559 1.052
;

proc univariate data=a1;
var karlsruhe;
histogram karlsruhe / normal kernel(color = red);
qqplot karlsruhe /normal (L=1 mu=est sigma=est);
run;quit;

proc univariate data=a1;
var lehigh;
histogram lehigh / normal kernel(color = red);
qqplot lehigh /normal (L=1 mu=est sigma=est);
run;quit;

proc univariate data=a1;
var diff;
histogram diff / normal kernel(color = red);
qqplot diff /normal (L=1 mu=est sigma=est);
run;quit;

proc ttest data=a1 h0=0;
	var diff;
run; quit;

proc means data = a1; run;
