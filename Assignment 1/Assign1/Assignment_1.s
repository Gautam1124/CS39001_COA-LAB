#Group No. 51
#Gautam Kumar(21CS30020)
#Ajay Kumar Dhakar(21CS30002)

.data						#data section,
prompt:						# prompt lebel for a string 
	.asciiz "Enter the value of x: "
out:						# out label for a string
	.asciiz "The value of e^x is: "
newline:					# label for newline
	.asciiz "\n"
		
num_iter:					# label for a printing number of iterations
	.asciiz "The numbe of iteration is: "

.text						# .text section : code starts
.globl main

main:						# main function
	la $a0 , prompt				# loading the adress of prompt in $a0
	li $v0 , 4				# assigning $v0 = 4 for print system call
	syscall					# system call
	
	li $v0, 5				# $v0 = 5 for taking the input
	syscall					# systemcall
	move $t0,$v0				# copying the value from input into $t0

	move $t1 ,$t0				# copying the same value in $t1
	li $t2 ,1				# initializng $t2 equals to 1
	li $t3 ,1				# initializng $t3 equals to 1
	li $t4 ,1				# initializng $t4 equals to 1

loop:						# loop label 
	div $t1,$t3				# dividing $t1 by $t3
	mflo $t5				# storing the quotient of $t3/$t1 in $t5
	add $t4,$t4,$t5				# adding the value of $t5 into $t4 ;;; $t4 = $t4 + $t5
	beq $t5 ,0,exit_loop			# break condition whenever $t5 equals to zero
	mul $t1,$t1,$t0				# multiplying the value of $t1 with $t0 and copying in $t1
	addi $t2,$t2,1				# increamenting the value of $t2 by 1
	mul $t3,$t3,$t2				# multiplying the value  of $t3 by $t2 and storing in $t3
	b loop					# branch loop ; go back to the loop label

exit_loop:					# exit_loop label
	la $a0,out				# loding the address of output message in $a0
	li $v0,4				# assigning system call code a value of 4 for printing string
	syscall					# system call
	
	move $a0,$t4				# copy the value of $t4 into $a0
	li $v0,1				# assigning system call code a value of 1 for printing int
	syscall					# system call
	
	la $a0, newline				# loading address of newling in #a0
	li $v0,4				# assigning system call code a value of 4 for printing string
	syscall					# system call

	la $a0, num_iter			# loading address of num_iter in #a0
	li $v0,4				#assigning system call code a value of 4 for printing string
	syscall					# system call
	
	move $a0,$t2				# copying the value of $t2 into $a0
	li $v0,1				# assigning system call code a value of 1 for printing int
	syscall					# system call

	li $v0,10				# assigning system call code a value of 10 for exit of program
	syscall					# system call
	
	
		
	
