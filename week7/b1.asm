#Le Thi Ngoc Thao, MSSV 20225673
#Gia tri tuyet doi 
.text 
main: 
	li $s0, -6
	jal abs
	nop 
	
	add $s0, $zero, $v0
	li $v0, 10    #terminate
	syscall 
endmain:

abs: 
	sub $v0, $zero, $a0     #put -(a0) in v0, in case (a0)<0
	bltz $a0, done
	
	add $v0, $a0, $zero     #else put (a0) in v0
	
done: 
	jr $ra 
