; Program Description: Recursive Fibonacci calculator
; Creation Date: November 27 2019 
; Revisions: 2
; Date: November 27 2019 

INCLUDE Irvine32.inc
 
.data
	FibSeq dword 0,1,1,99 dup(?)
	N dword ?
	Prompt BYTE 'Enter your N : ',0
	Message BYTE 'Fibonacci sequence with N = ',0
	Message2 BYTE ' is: ',0
.code
main proc 
	mov edx, offset Prompt
	call writeString
	call readInt
	.IF eax <= 3	;If selected paramter is too low, default to 3
		mov eax,3
	.ENDIF
	mov N,eax	;Save size of sequence in N
	call FibStart	;Fibonacci function will return last element into eax


	mov ebp, offset FibSeq ;Get pointer to start printing array


	;Printing code
	mov edx, offset Message
	call writeString
	push eax		;Push result from Fib function to stack, we need to use the eax register
	mov eax, N
	call writeDec
	mov edx, offset Message2
	call writeString
	mov ecx, N		;Loop counter
	l1:
		mov eax, [ebp]
		call writeDec
		mov al,' '
		call writeChar
		add ebp, 4
	loop l1
	pop eax		;Pop last element from fib sequence back from stack and print
	call writeDec
	exit
main ENDP


;eax = k parameter
FibStart proc
	sub eax,2	;we will subtract 2 from the counter since we already have 0,1,1 in the sequence array
	mov edi, offset FibSeq + 4	;These two pointers save current value
	mov ebp, offset FibSeq + 8	;and previous value so that recursive fib function can calculate sequence
	call Fib
	ret
FibStart ENDP

;Recursive fibonacci function
Fib proc
	.IF eax == 0 
		mov eax, [ebp]
		ret
	.ELSE
		mov edx, [ebp]
		add edx, [edi]	;add previous value to current value
		mov [ebp]+4, edx
		dec eax		;dec counter
		add ebp,4	;shift pointer
		add edi,4
		call Fib	;recurse
		ret
	.ENDIF
Fib ENDP


END main