data hormone;
input trt resp;
datalines;
1 106
1 101
1 120
1 86
1 132
1 97
2 51
2 98
2 85
2 50
2 111
2 72
3 103
3 84
3 100
3 83
3 110
3 91
4 50
4 66
4 61
4 72
4 85
4 60
;

proc glm;
	class trt;
	model resp=trt;
	contrast 'Hormone I vs Hormone II' trt 1 1 -1 -1;
	contrast 'Low Level vs High Level' trt 1 -1 1 -1;
	contrast 'Equivalence of Levels' trt 1 -1 -1 1;
run;
