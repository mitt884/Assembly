#Le Thi Ngoc Thao, 20225673
#Tim so lon nhat trong 3 so
.text 
main: 
	li $a0, 4
	li $a1, 100
	li $a2, -3
	jal max
	nop
	
	add $a0, $zero, $v0    #print result 
	li $v0, 1
	syscall
	li $v0, 10     #terminate
	syscall      
	
endmain: 
max: 
	add $v0, $a0, $zero     #copy a0 in v0
	sub $t0, $a1, $v0       #compute a1-v0
	bltz $t0, okay          # if (a1-v0) < 0, no change 
	nop
	
	add $v0, $a1, $zero     # else (a1) is the largest 
okay: 	
	sub $t0, $a2, $v0      #comput a2 - v0
	bltz $t0, done        #if (a2 - v0) < 0 then no change 
	nop
	add $v0, $a2, $zero    #else a2 is the largest overall 
	
done: 
	jr $ra
