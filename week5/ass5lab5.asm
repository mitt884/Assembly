.data
	String: .space 21
	Reverse: .space 21
	message1: .asciiz " \n Chuoi da nhap la: "
	message2: .asciiz " \n Chuoi dao nguoc la: "
.text 
	li $t0, 0           #index i
	li $t1, 20          #max length
	li $t2, 0x0a        #enter character 
	la $s0, String
	la $s1, Reverse 
get_string:
	li $v0, 12          #read character
	syscall 
	beq $v0, $t2, end_get_string  # end loop if new line
	add $t3, $t0, $s0  #address of string[i]
	sb $v0, 0($t3)     
	addi $t0, $t0, 1     #i=i+1
	bge $t0, $t1, end_get_string #end loop if length of string > 20
	j get_string
end_get_string:
	add $t4, $zero, $t0     # $t4 = length of string
	subi  $t4, $t4, 1    # tru di 1 de lay vi tri cua phan tu cuoi cung
	add $t6, $zero, $s1    #get address reverse[j]
get_reverse: 
	add $t3, $t4, $s0    #lay phan tu cuoi cung cua string
	lb $t5, 0($t3)       # $t5 = string[i]
	beqz $t5, end_get_reverse    # #end loop if t5 null 
	sb $t5, 0($t6)     #reverse [j] = t5 = string[i]
	subi $t4, $t4, 1   # i = i - 1
	addi $t6, $t6, 1   # j = j + 1
	j get_reverse 
end_get_reverse:

print_string: 
	li $v0, 4
	la $a0, message1
	syscall 
	la $a0, String
	syscall
	la $a0, message2
	syscall
	la $a0, Reverse
	syscall 
