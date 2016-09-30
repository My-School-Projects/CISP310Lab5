.586
.MODEL FLAT	; only 32 bit addresses, no segment:offset

INCLUDE io.h   ; header file for input/output

.STACK 4096	   ; allocate 4096 bytes for the stack

.DATA

	; The purpose of this program is to find the weighted average of 4 grades,
	; each with an independent weight.

	; We will be using DWORDS, because the problem spec said to.
	; We will treat all values as unsigned integers, because this problem does not involve
	; any negative numbers.
	
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

	gradePrompt		BYTE	"Grade "		; Stays constant
	gradeNumber		BYTE	"X"				; "X" will be replaced with a ASCII coded digit at runtime
					BYTE	" [0-100]:", 0	; Stays constant - null terminated

	weightPrompt	BYTE	"Weight "		; Stays constant
	weightNumber	BYTE	"X"				; "X" will be replaced with a ASCII coded digit at runtime
					BYTE	" [0-100]:", 0	; Stays constant - null terminated

	; The input macro needs a C-string to store the data in.
	; We're using a 4 character string because our valid input range is 0 to 100,
	; and the largest valid input will be "100", and we need four bytes
	; to store "100" as a C-string (3 ASCII digits + Null terminator)

	inputStr		BYTE	4	DUP	(0)

	; The output macro needs a C-string (null-terminated string) to display as a label,
	; and a C-string to display as a message.

	; outputValue will be replaced at runtime with an 11 character string which will hold the decimal
	; value of weightedAverage

	outputLabel		BYTE	"Weighted Average:", 0	; Label to be displayed upon output
	outputValue		BYTE	11	DUP	("X")			; Space for result of dtoa (11 ASCII coded bytes)
					BYTE	0						; Null string terminator

.CODE
_MainProc PROC
	
	; Get grade1 and weight1

	mov		gradeNumber,		"1"			; Set gradePrompt to "Grade 1:"
	mov		weightNumber,		"1"			; Set weightPrompt to "Weight 1:"

	; We pass 4 to the input macro, which specifies that we want to copy a maximum of 4 bytes into memory.
	; 3 of those bytes will be ASCII coded digits (0-100), and the last will be a Null string terminator.

	input	gradePrompt,		inputStr,	4	; Display prompt, inputStr := user input (as string)
	atod	inputStr						; EAX := user input (as integer)
	mov		grade1,				eax			; grade1 := EAX

	input	weightPrompt,		inputStr, 4
	atod	inputStr
	mov		weight1,			eax			; weight1 := user input (as integer)

	; Get grade2 and weight2 (see grade1, weight1 for comments)

	mov		gradeNumber,		"2"			; Set gradePrompt to "Grade 2:"
	mov		weightNumber,		"2"			; Set weightPrompt to "Weight 2:"
										
	input	gradePrompt,		inputStr,	4
	atod	inputStr
	mov		grade2,				eax

	input	weightPrompt,		inputStr, 4
	atod	inputStr
	mov		weight2,			eax

	; Get grade3 and weight3 (see grade1, weight1 for comments)

	mov		gradeNumber,		"3"
	mov		weightNumber,		"3"

	input	gradePrompt,		inputStr,	4
	atod	inputStr
	mov		grade3,				eax

	input	weightPrompt,		inputStr, 4
	atod	inputStr
	mov		weight3,			eax
	
	; Get grade4 and weight4 (see grade1, weight1 for comments)

	mov		gradeNumber,		"4"
	mov		weightNumber,		"4"

	input	gradePrompt,		inputStr,	4
	atod	inputStr
	mov		grade4,				eax

	input	weightPrompt,		inputStr,	4
	atod	inputStr
	mov		weight4,			eax

	; Do the math!

	mov		eax,				grade1
	mul		weight1
	mov		weightedGrade1,		eax				; weightedGrade1 := grade1 * weight1
												; weightedGrade1 := 43 * 40 (1720)

	mov		eax,				grade2
	mul		weight2
	mov		weightedGrade2,	 eax				; weightedGrade2 := grade2 * weight2

	mov		eax,				grade3
	mul		weight3
	mov		weightedGrade3,		eax				; weightedGrade3 := grade3 * weight3

	mov		eax,				grade4
	mul		weight4
	mov		weightedGrade4,		eax				; weightedGrade4 := grade4 * weight4

	mov		eax,				weightedGrade1	; EAX := weightedGrade1
	add		eax,				weightedGrade2	; EAX := weightedGrade1 + weightedGrade2
	add		eax,				weightedGrade3	; EAX := weightedGrade1 + weightedGrade2 + weightedGrade3
	add		eax,				weightedGrade4	; EAX := weightedGrade1 + weightedGrade2 + weightedGrade3 + weightedGrade4
	mov		weightedSum,		eax				; weightedSum := EAX

	mov		eax,				weight1			; EAX := weight1
	add		eax,				weight2			; EAX := weight1 + weight2
	add		eax,				weight3			; EAX := weight1 + weight2 + weight3
	add		eax,				weight4			; EAX := weight1 + weight2 + weight3 + weight4
	mov		sumOfWeights,		eax				; sumOfWeights := EAX

	; Division by a DWORD requires the dividend to be stored in EDX:EAX
	mov		edx,				0				; EDX := 0 (our dividend is only 32 bits - only the lower order bits are used)
	mov		eax,				weightedSum		; EAX := weightedSum
	div		sumOfWeights						; EAX := weightedSum / sumOfWeights
	mov		weightedAverage,	eax				; weightedAverage := EAX

	dtoa	outputValue,		eax				; Interpolate weightedAverage into outputMessage
	output	outputLabel,		outputValue		; Display the final result to the user

	mov		eax,				0				; exit with return code 0
	
	ret
_MainProc ENDP

END   ; end of source code
