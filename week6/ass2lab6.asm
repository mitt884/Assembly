#Le Thi Ngoc Thao, MSSV 20225673
.data
	prompt1: .asciiz "\nEnter array length: "
	prompt2: .asciiz "Enter a number: " 
	comma: .asciiz ", "
	newline: .asciiz "\n"
	A: .word
.text 
main: 
	la $a0, prompt1 
	li $v0, 4 
	syscall
	li $v0, 5 
	syscall
	add $a1, $zero, $v0   #length 
	addi $t0, $zero, 0  #i 
read: 
	beq $t0, $a1, end_read 
	la $a0, prompt2
	li $v0, 4
	syscall   
	li $v0, 5
	syscall
	la $a0, A
	add $t2,$t0,$t0
	add $t2, $t2, $t2
	add $t3, $t2, $a0     #4i+A = address A[i]
	sw $v0, 0($t3)
	addi $t0, $t0, 1
	j read
	
end_read:
	add $a1, $zero, $t3   #address A[n-1]
	j sort
after_sort:
 	li $v0, 10 
 	syscall
 	
 end_main:
 
 sort: 
 	beq $a0, $a1, done
 	j max
 	
 after_max: 
 	lw $t0, 0($a1)   
 	sw $t0, 0($v0)
 	sw $v1, 0($a1)
 	addi $a1, $a1, -4
 	li $v0, 4
 	la $a0, newline
 	syscall
 	la $s0, A
 	add $s1, $zero, $t3
 	
 print: 
 	li $v0, 1
 	lw $a0, 0($s0)
 	syscall
 	addi $s0, $s0, 4
 	bgt $s0, $s1, endprint
 	
 	li $v0, 4
 	la $a0, comma
 	syscall 
 	j print 
 
 endprint: 
 	li $v0, 4
 	la $a0, newline
 	syscall
 	la $a0, A
 	j sort
 
 done:  j after_sort
 
 max: 
  	addi $v0, $a0, 0
  	lw $v1, 0($v0)
  	addi $t0, $a0, 0
  	
 loop: 
 	beq $t0, $a1, ret
 	addi $t0, $t0, 4
 	lw $t1, 0($t0)
 	slt $t2, $t1, $v1
 	bne $t2, $zero, loop
 	addi $v0, $t0, 0
 	addi $v1, $t1, 0
 	j loop
 	
 ret: 
 	j after_max
 
 	
	