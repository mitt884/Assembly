#Lab 6 assignment 1
#Le Thi Ngoc Thao, MSSV 20225673
.data 
A: .word -2, 10, -6, -3, 5
result: .asciiz " Max sum prefix is: "
length: .asciiz " with length "

.text 
main: 
	la $a0, A
	li $a1, 5
	j mspfx
	nop
continue:
	j msfx_end
lock: 
	j lock
	nop
end_of_main:

mspfx: 
	addi $v0, $zero, 0
	addi $v1, $zero, 0     #max sum
	addi $t0, $zero, 0     #i
	addi $t1, $zero, 0     #running sum
loop: 
	add $t2, $t0, $t0
	add $t2, $t2, $t2
	add $t3, $t2, $a0      #address of A[i]
	lw $t4, 0($t3)         #load A[i] -> t4
	add $t1, $t1, $t4      # sum = sum + A[i]
	slt $t5, $v1, $t1      #if max sum < new sum -> set t5 = 1 
	bne $t5, $zero, mdfy   #if max sum is less, modify result
	j test
mdfy: 
	addi $v0, $t0, 1       #max sum prefix has length i+1
	addi $v1, $t1, 0       #max sum is the running sum
test: 
	addi $t0, $t0, 1
	slt $t5, $t0, $a1      #if i<n => set t5 = 1
	bne $t5, $zero, loop   #repeat if i<n
done: j continue
msfx_end:
	add $s1, $zero, $v0
	
	la $a0, result 
	li $v0, 4
	syscall
	
	add $a0, $zero, $v1
	li $v0, 1
	syscall
	
	la $a0, length
	li $v0, 4
	syscall 
	
	add $a0, $zero, $s1
	li $v0, 1
	syscall