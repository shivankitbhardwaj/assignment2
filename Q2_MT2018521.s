; tanx series
     AREA    tan,CODE,READONLY
     EXPORT __main
     ENTRY
__main  FUNCTION
; IGNORE THIS PART  
        MOV R0,#10 ; iteration value for expression expansion 'n'
        MOV R1,#1; counting Variable 'i'
        VLDR.F32 S0,=1;Holding the final value of sum of series elements 's' (e^x)
        VLDR.F32 S1,=1;Temp Variable to hold the intermediate series elements 't'
        VLDR.F32 S2,=340;Holding 'x' value(in degrees)
	 	VLDR.F32 S7,=0.0174533; changing degress into radians 
		VMUL.F32 S2,S2,S7 ; changing degress into radians 
		VMOV.F32 S1,S2; t=x for sine
		VMOV.F32 S0,S2; sum=x for sine
		VLDR.F32 S8,=1; t=1 for cosine
		VLDR.F32 S9,=1; sum=1 for cosine
		
LOOP1   CMP R1,R0;Compare 'i' and 'n'
        BLE LOOP;if i < n goto LOOP
stop    B stop;else goto stop

LOOP  	VMOV.F32 S3,R1; moving the value of 'i' in floating register
        VCVT.F32.U32 S3,S3; Converting the value present in R1(i) into unsigned fp Number 32 bit
		VNMUL.F32 S4,S2,S2; -1*x*x
		MOV R5,#2
		MUL R2,R1,R5; 2i
		ADD R3,R2,#1; 2i+1 for sine
		SUB R6,R2,#1; 2i-1 for cosine
		MUL R3,R2,R3; 2i*(2i+1)  for sine
		MUL R7,R2,R6; 2i*(2i-1) for cosine
        VMOV.F32 S5,R3; moving the value of '2i*(2i+1)' in floating register
		VMOV.F32 S10,R7; moving the value of '2i*(2i-1)' in floating register
        VCVT.F32.U32 S5,S5; Converting the value present in R3(2i*(2i+1)) into unsigned fp Number 32 bit)
		VCVT.F32.U32 S10,S10; Converting the value present in R7(2i*(2i-1)) into unsigned fp Number 32 bit)
		VDIV.F32 S6,S4,S5 ; -(x*x)/2i*(2i+1)
		VDIV.F32 S11,S4,S10 ; -(x*x)/2i*(2i-1)
		VMUL.F32 S1,S1,S6; t=t*(-1)*(x*x)/2i*(2i+1)
		VMUL.F32 S8,S8,S11; t=t*(-1)*(x*x)/2i*(2i-1)
		VADD.F32 S0,S0,S1;Finally add 's' to 't'(S1) and store it in 's'
		VADD.F32 S9,S9,S8;Finally add 's' to 't'(S8) and store it in 's'
		VDIV.F32 S12,S0,S9; final tanx value
		ADD R1,R1,#1; increment the value of i by 1
		B LOOP1;;Again goto comparision
		
		endfunc
        end