CSEG AT 0
JMP start
CSEG AT 30h
  start:
	MOV A,#1
  loop:
    MOV R0,#0xFF
	MOV P2,A
	RL A
  while:
	DJNZ R0,loop
	NOP
	JMP while
		
END 