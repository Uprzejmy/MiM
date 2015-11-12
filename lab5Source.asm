arrayPtr DATA 16d
counter EQU 16

CSEG AT 0
AJMP start

CSEG AT 23h
AJMP serialHandler

CSEG AT 30h
serialHandler:
	JNB RI,$ ; sprawdzenie flagi odbioru
	MOV A,SBUF ; czytanie z uarta
	DJNZ R1,next ; zmniejszamy licznik bufora
		
	;jezeli licznik bufora doszedl do konca to trzeba go zresetowac
	MOV R0,#arrayPtr
	MOV R1,#counter
next:
	MOV @R0,A ; wrzucamy do ramu dana z uarta
	INC R0; przechodze na kolejne miejsce bufora
		
	CLR RI ; zerowanie flagi odbioru
	CLR P2.0
		
	MOV SBUF,A ; zapis do uarta
	JNB TI,$ ; czekanie na opróznienie bufora nadajnika
	CLR TI ; wyzerowanie flagi wyslania
	SETB P2.0
	RETI ; wyjscie z obslugi przerwania
start:
	SETB EA ;odblokowanie przerwan
	SETB ES ;odblokowanie przerwan portu szeregowego
	MOV R0,#arrayPtr ;przenosze do R0 adres bufora cykliczengo
	MOV R1,#counter ;;przenosze do R1 iterator bufora cyklicznego
	MOV SCON,#50h ; uart w trybie 1 (8 bit), REN=1
	MOV TMOD,#20h ; licznik 1 w trybie 2
	MOV TH1,#0FDh ; 9600 Bds at 11.0592MHz
	SETB TR1 ; uruchomienie licznika
	CLR TI ; wyzerowanie flagi wyslania
	
	while:
		NOP
		JMP while	
	
END