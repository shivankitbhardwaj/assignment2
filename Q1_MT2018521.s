; exponential function e^x
     AREA    exponential,CODE,READONLY
     EXPORT __main
     ENTRY
__main  FUNCTION
; IGNORE THIS PART  
        MOV R0,0xF ; iteration value for expression expansion
        MOV R1,#1; counting Variable 'i'
        VLDR.F32 S0,=1;Holding the final value of sum of series elements 's' (e^x)
        VLDR.F32 S1,=1;Temp Variable to hold the intermediate series elements 't'
        VLDR.F32 S2,=10;Holding 'x' Value
LOOP1   CMP R1,R0;Compare 'i' and 'n'
        BLE LOOP;if i < n goto LOOP
        B stop;else goto stop

LOOP    VMUL.F32 S1,S1,S2; t = t*x
        B fact ;calculte the factorial value of counting variable stored in R1(i) which further will used in denominator of expression
facm    VMOV.F32 S5,R7;Moving the value of i! in R7 = R1!('i!') to S5(floating point register)
        VCVT.F32.U32 S5,S5;Converting the value present in R7(i!) into unsigned fp Number 32 bit
        VDIV.F32 S3,S1,S5;Divide t by 'i!' and store it into new temperory variable s3
        VADD.F32 S0,S0,S3;Finally add 's' to 'S3' and store it in 's'
        ADD R1,R1,#1;Increment the counter variable 'i'
        B LOOP1;Again goto comparision

 ; factorial program to find the factorial of counting variable 'i' 
fact	MOV r7,#1 ; if n = 0, at least 'i!' = 1
        MOV R6,R1 ; move value of R1('i') to R6 ('n') to store intermediate values during operation
loop2   CMP r6, #0 ; compare the value of n to zero
        MULGT r7, r6, r7 ; if i!=0
        SUBGT r6, r6, #1 ; decrement 'n'
        BGT loop2 ; do another mul if counter!= 0
        B facm ; pass the final factorial value when n=0
	

stop    B stop  ; stop program
        endfunc
        end