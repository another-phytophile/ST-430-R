
/* MErge Test*/
data A;
input code $ x y;
datalines;
AA 1 2
AA 3 4
AA 5 6
BB 7 8
CC 9 10
;
run;

data test10;
	set a;
	avis=intck("year", "14MAR2019"d,"13MAR2023"d,"continuous");
run;

/*14*/
proc transpose data=A prefix== AVIS;
	by code;
run;

data B;
input code $ z 2. k;
datalines;
AA  10  20
AA 20 .
BB 70 80
BB 99 77
CC 90 100
CC 91 20
DD 12 .
;
run;

Proc sort data = A; By code; Run;
Proc sort data = B; By code; Run;

Data c;
Merge A (in =ina) B (in=inb);
If ina=1 and inb=1;
Run;

/*q5 test*/
data avis;
	set B;
	count+k;
run;

/*a6 test*/
DATA example;
    INPUT avis 5. cat 1.;
    DATALINES;
    12345 3
    .   5
    67890  2
    ;
RUN;

/*q16*/
libname avis "C:\Users\yujer\Documents\ST-430-R\Datasets";

data q16;
	infile "C:\Users\yujer\Documents\ST-430-R\Datasets\SAS";
	input avis 1. cat 4-6;
run;

/*q18*/
data A B;
input code $ z k;
if code = "AA" then output A;
if code = "BB" then output B;
datalines;
AA 10 20
AA 20 .
BB 70 80
BB 99 77
CC 90 100
CC 91 20
DD 12 .
;
run;

data B;
format avisdate MMDDYY.;
input code $ @;
	
datalines;
AA 10  20
BB 20 .
AA 70 80
BB 99 77
CC 90 100
CC 91 20
DD 12 .
;
run;