PROG SEGMENT CODE
arrayPtr DATA 50d;miejsce w ram gdzie bedzie trzymana tablica
randomBytes: db 0,0,0
counter1 EQU 10;ilosc generowanych liczb
counter2 EQU 10;ilosc danych do przepisania z pamieci do ramu
counter3 EQU 0;licznik wspomagajacy przepisywanie pamieci do ramu
array: db 4,5,3,3,3,4,6,2,6,5
j EQU 56 ;7-1 potrzeba dodawania offsetu w tablicy
k EQU 59 ; 10-1 jw


;PROG SEGMENT CODE
CSEG AT 0
JMP start
RSEG PROG

	move:	
		CLR A
		MOV DPTR,#array
		MOV A,R2
		MOVC A,@A+DPTR
		MOV @R0,A
		INC R0
		INC R2
		
		DJNZ R1,move
		
		RET
	
	generator:
		MOV A,R2
		MOV R0,A
		MOV A,R3
		MOV R1,A
		
		MOV A,@R0
		MOV B,@R1
		INC R0
		INC R1
		ADD A,B
		MOV B,#4
		DIV AB
		MOV @R1,B
		
		MOV A,R0
		MOV R2,A
		MOV A,R1
		MOV R3,A
		
		RET
		
		;DIV AB ;A = A div B, B = A mod B
	start:
	
		MOV R0,#arrayPtr
		MOV R1,#counter2
		MOV R2,#counter3
		ACALL move
		
		MOV R2,#j
		MOV R3,#k
		MOV R0,#counter1
	main:
		MOV A,R0
		MOV R4,A
		ACALL generator
		MOV A,R4
		MOV R0,A
		DJNZ R0,main
	
	SJMP $
END