
; Program Description: Recursive GCD Function
; Creation Date: November 27 2019 
; Revisions: 1
; Date: November 27 2019 

INCLUDE Irvine32.inc
 
.data
	X dword 512		;Insert X here
	Y dword 1024	;Insert Y here
	Message BYTE 'GCD = ',0
.code
main proc
	mov eax,X
	mov ecx,Y
	mov edx, offset Message
	call writeString
	call GCD
	call writeDec
	exit
main ENDP


;eax = a parameter
;ecx = b parameter
;Result is stored in eax
GCD proc
	.IF ecx == 0 
		ret
	.ELSE
		mov edx,0	; clear dividend, high
		div ecx		;div
		mov eax, ecx	; a = old b
		movzx ecx, dx   ; b = a mod b
		call GCD ; recurse
		ret
	.ENDIF
GCD ENDP


END main