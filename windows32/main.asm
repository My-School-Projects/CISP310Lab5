.586
.MODEL FLAT	; only 32 bit addresses, no segment:offset

INCLUDE io.h   ; header file for input/output

.STACK 4096	   ; allocate 4096 bytes for the stack

.DATA

	; The purpose of this program is to find the weighted average of 4 grades,
	; each with an independent weight.

	; We will be using DWORDS, because scores of more than 65535 (2^16 - 1) seem reasonable,
	; and scores of more than 4294967295 (2^32 - 1) do not.
	
	grade1			DWORD	0
	grade2			DWORD	0
	grade3			DWORD	0
	grade4			DWORD	0
	
	weight1			DWORD	0
	weight2			DWORD	0
	weight3			DWORD	0
	weight4			DWORD	0
	
	weightedGrade1	DWORD	0	; = grade1 * weight1
	weightedGrade2	DWORD	0	; = grade2 * weight2
	weightedGrade3	DWORD	0	; = grade3 * weight3
	weightedGrade4	DWORD	0	; = grade4 * weight4

	weightedSum		DWORD	0	; = weightedGrade1 + weightedGrade2 + weightedGrade3 + weightedGrade4

	sumOfWeights	DWORD	0	; = weight1 + weight2 = weight3 + weight4

	; FINAL RESULT
	weightedAverage	DWORD	0	; = weightedSum / sumOfWeights


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

	weightPrompt	BYTE	"Weight "	; Stays constant
	weightNumber	BYTE	"X"			; "X" will be replaced with a number at runtime
					BYTE	":", 0		; Stays constant - null terminated

	; The input macro needs a 40 character string to store data in

	string			BYTE	40	DUP	(0)
	

.CODE
_MainProc PROC
	
	; Get grade1 and weight1

	mov		gradeNumber,	"1"			; Set gradePrompt to "Grade 1:"
	mov		weightNumber,	"1"			; Set weightPrompt to "Weight 1:"

	input	gradePrompt,	string,	40	; Display prompt, string := user input (as string)
	atod	string						; EAX := user input (as integer)
	mov		grade1,			eax			; grade1 := EAX

	input	weightPrompt,	string, 40
	atod	string
	mov		weight1,		eax			; weight1 := user input (as integer)

	; Repeat the same steps as above for grades 2, 3 and 4

	; Get grade2 and weight2

	mov		gradeNumber,	"2"			; Set prompt to "Grade 2:"
	mov		weightNumber,	"2"			; Set weightPrompt to "Weight 2:"
										
	input	gradePrompt,	string,	40
	atod	string
	mov		grade2,			eax

	input	weightPrompt,	string, 40
	atod	string
	mov		weight2,		eax

	; Get grade3 and weight3

	mov		gradeNumber,	"3"
	mov		weightNumber,	"3"

	input	gradePrompt,	string,	40
	atod	string
	mov		grade3,			eax

	input	weightPrompt,	string, 40
	atod	string
	mov		weight3,		eax
	
	; Get grade4 and weight4

	mov		gradeNumber,	"4"
	mov		weightNumber,	"4"

	input	gradePrompt,	string,	40
	atod	string
	mov		grade4,			eax

	input	weightPrompt,	string,	40
	atod	string
	mov		weight4,			eax

	; Do the math!

	; TODO

	mov		eax,			0			; exit with return code 0
	ret
_MainProc ENDP

END   ; end of source code
