PROG SEGMENT CODE
CSEG AT 0
JMP start
RSEG PROG
  start:
	MOV P2,#0
	MOV P3,0
	MOV TH0,#76
	MOV TL0,#01
	MOV TMOD,#9
	SETB TR0 ; startujemy timer 0
	
	working:
	JNB TF0,$ ;Jezeli TF0 nie jest ustawione to nie ma przepelnie
	INC A
	CLR TF0
	MOV TH0,#76
	CJNE A,#20,working
	
	;if 20
	MOV A,P2
	ADD A,P2
	INC A
	MOV P2,A
	CLR A
	JMP working
	
	

END 