#Lab 6, Assignment 3
# Le Thi Ngoc Thao - MSSV 20225673
.data
A:         .word    -1, 5, 8, 23, 3, 4, 1, -9
Aend:        .word
messsge:    .asciiz "Sorted array: "
message1:     .asciiz ""
message2:      .asciiz "," 

.text
    la $t0, A        #address of A[0]
    la $t1, Aend
    sub $s0, $t1, $t0
    srl $s0, $s0, 2         #length of A
    sub $s4, $s0, 1         #length of A - 1
    add $s1, $s1, $zero     #i
    addi $s2, $s1, 1        #j = i + 1
loop1:
    bge $s1, $s0, exiti    #if i >= n  then exit or for (i = 0; i < n; i++)
    addi $s2, $s1, 1    #j = i + 1
loop2:
    bge $s2, $s0, exitj    #for(j = i+1; j < n; i++)

    add $t2, $s1, $s1    #t2 = i+i
    add $t2, $t2, $t2    #t2 = 4i
    add $t3, $t2, $t0    #t3 = address of A[i]
    lw  $t4, 0($t3)        #t4 = A[i]

    add $t5, $s2, $s2    #t5 = j+j
    add $t5, $t5, $t5    #t5 = 4j
    add $t6, $t5, $t0    #t6 = address of A[j]
    lw  $t7, 0($t6)        #t7 = A[j]

    sgt $s3, $t4, $t7    #s3 = (A[i] > A[j])? 1 : 0 s3 = 0 if A[i] <= A[j]
    beq $s3, $zero, exitif #if A[i] <= A[j] then don't swap

      # swap A[i] and A[j] based on their address 
    sw $t7, 0($t3)        #swap address of A[i] -> A[j] 
    sw $t4, 0($t6)        #swap address of A[j] -> A[i]

exitif:
    addi $s2, $s2, 1    #j = j+1
    j loop2
exitj: 
    addi $s1, $s1, 1
    j loop1
exiti:

    li $v0, 4
    la $a0, messsge
    syscall

    la $t0, A        #address of A[0]
    add $s1, $zero, $zero     #i
    add $t2, $t2, $zero
    add $t3, $t3, $zero
    add $t4, $t4, $zero

loop:
    bge $s1, $s0, end    #if i >= n  then exit or for (i = 0; i < n; i++)
    add $t2, $s1, $s1    #t2 = i+i
    add $t2, $t2, $t2    #t2 = 4*i
    add $t3, $t2, $t0    #t3 = address of A[i]
    lw  $t4, 0($t3)        #t4 = A[i]

    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, message1
    syscall 
    
    bge $s1, $s4, endif_print
    li $v0, 4
    la $a0, message2
    syscall

    addi $s1, $s1, 1
    j loop
endif_print: 
    add $s1, $s1, 1
    j loop
end:
    li $v0, 10
    syscall
