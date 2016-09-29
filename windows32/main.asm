.586
.MODEL FLAT	; only 32 bit addresses, no segment:offset

INCLUDE io.h   ; header file for input/output

.STACK 4096	   ; allocate 4096 bytes for the stack

.DATA

	; We will be using DWORDS, because scores of more than 65535 seem reasonable,
	; and scores of more than 4294967295 do not.
	
	grade1			DWORD	0
	grade2			DWORD	0
	grade3			DWORD	0
	grade4			DWORD	0
	
	weight1			DWORD	0
	weight2			DWORD	0
	weight3			DWORD	0
	weight4			DWORD	0


	; The input macro expects a C-string (null terminated string) to display as a prompt.

	; We need 8 prompts, 4 for grades and 4 for weights, and the prompts are almost exactly
	; the same for each, except that each ends with a number that will increment with each use.
	; Instead of duplicating the same prompt 4 times in memory, we will use one prompt and change
	; the number before each use.

	; The actual prompts will look like:
	; "Grade 1:"
	; or
	; "Weight 3:"
	; depending on the iteration.

	gradePrompt		BYTE	"Grade "	; Stays constant
	gradeNumber		BYTE	"X"			; "X" will be replaced with a number at runtime
					BYTE	":", 0		; Stays constant - null terminated

	weightPrompt1	BYTE	"Weight "	; Stays constant
	weightNumber	BYTE	"X"			; "X" will be replaced with a number at runtime
					BYTE	":", 0		; Stays constant - null terminated

	; The input macro needs a 40 character string to store data in

	string			BYTE	40	DUP	(0)
	

.CODE
_MainProc PROC
	
	mov		gradeNumber,	"1"			; Set prompt to "Grade 1:"

	input	gradePrompt,	string,	40	; Display prompt, string := user input (as string)
	atod	string						; EAX := user input (as integer)
	mov		grade1,			eax			; grade1 := EAX

	mov		gradeNumber,	"2"			; Set prompt to "Grade 2:"

	input	gradePrompt,	string,	40	; Repeat the same steps as above for grades 2, 3 and 4
	atod	string
	mov		grade2,			eax

	mov		gradeNumber,	"3"

	input	gradePrompt,	string,	40
	atod	string
	mov		grade3,			eax
	
	mov		gradeNumber,	"4"

	input	gradePrompt,	string,	40
	atod	string
	mov		grade4,			eax

	mov		eax,			0			; exit with return code 0
	ret
_MainProc ENDP

END   ; end of source code
