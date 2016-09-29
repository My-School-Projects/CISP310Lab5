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


	; The input macro expects a C-string (null terminated string)

	gradePrompt1	BYTE	"Grade 1:", 0
	gradePrompt2	BYTE	"Grade 2:", 0
	gradePrompt3	BYTE	"Grade 3:", 0
	gradePrompt4	BYTE	"Grade 4:", 0

	weightPrompt1	BYTE	"Weight 1:", 0
	weightPrompt2	BYTE	"Weight 2:", 0
	weightPrompt3	BYTE	"Weight 3:", 0
	weightPrompt4	BYTE	"Weight 4:", 0
	

.CODE
_MainProc PROC
	



	mov		eax,	0	; exit with return code 0
	ret
_MainProc ENDP

END   ; end of source code
