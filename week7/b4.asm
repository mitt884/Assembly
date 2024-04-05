#Le Thi Ngoc Thao, 20225673
#Tinh giai thua 
# int fact(int n){ 
#          if(n<1) return 1;
#          else return n * fact(n-1); 
#       }
.data 
Message:   .asciiz "Ket qua tinh giai thua la: "
Input: .asciiz "Nhap so N: "

.text 
main: 
	li $v0, 4
	la $a0, Input
	syscall 
	li $v0, 5
	syscall   
	add $a0, $zero, $v0     #load input N
	jal WARP

print: 
	add $a1, $v0, $zero     #a0 = result 
	li $v0, 4
	la $a0, Message
	syscall
	li $v0, 1
	add $a0, $zero, $a1
	syscall

quit: 
	li $v0, 10 
	syscall
	
endmain: 
WARP: 
	sw $fp, -4($sp) #save frame poinnter 1
	addi $fp, $sp, 0    #new frame pointer point to the top 2
	addi $sp, $sp, -8   #adjust stack pointer 
	sw $ra, 0($sp)      #save return address 
	jal FACT           #call fact 
	nop
	
	lw $ra, 0($sp)
	addi $sp, $fp, 0
	lw $fp, -4($sp)
	jr $ra
wrapend:

FACT: 
	sw $fp, -4($sp)     #save from pointer
	addi $fp, $sp, 0    #new frame pointer point to stack a
	addi $sp, $sp, -12   #allocate space for $fp, $ra, $a0
	sw $ra, 4($sp)    #save the return address
	sw $a0, 0($sp)    #save return register
	slti $t0, $a0, 1     #if input N < 2
	beq $t0, $zero, recursive    # if false 
	nop
	li $v0, 1
	j done              #return N! = 1
	nop
	

recursive: 
	addi $a0, $a0, -1    #adjust input arrgument 
	jal FACT             #recursive call
	nop
	lw $v1, 0($sp)
	mult $v1, $v0
	mflo $v0
	
done: 
	lw $ra, 4($sp)     #restore return address
	lw $a0, 0($sp)     #restore a0
	addi $sp, $fp, 0   #restore stack pointer 
	lw $fp, -4($sp)    #restore frame poinnter 
	jr $ra
	
factend:
