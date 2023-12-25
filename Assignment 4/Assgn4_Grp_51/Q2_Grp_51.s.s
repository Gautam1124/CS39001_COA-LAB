.data
message:
	.asciiz "Enter the number \n"
check:
	.asciiz "The number entered is less than one 404 error \n"
step_message:
	.asciiz "The number of step required is:: "

.text
.globl main

#$s0 = n;
#$s1= m
#$s2 = step
#$s3 = n%2 

main:
	la $a0,message	# copying message address in $a0
	li $v0,4
	syscall		# system call for printing
	
	li $v0,5
	syscall		# system call for taking the input
	move $s0,$v0	# moving the value of n into $s0

	bgt $s0,0,main2	# doing sanitry check jump to main2 if value entered is greate than -1
	la $a0,check
	li $v0,4
	syscall		# system call for printing error message
	b main		# branching to main for retaking the input
main2:

	li $s2,0	# making the step as the global variable and assigning it to 0
	jal collatz	# jal to collatz
	
	la $a0,step_message	#system call for printing output message
	li $v0,4
	syscall


	move $a0,$s2		# After the completing of recursive calling of collatz the returned value is stored in s2
	li $v0,1
	syscall
	b exit

collatz:
	subu $sp,$sp,8		# allocate 8 byte of memory
	sw $ra,($sp)		# storing the return address in ($sp)
	sw $s1,4($sp)		# storing the parameter passed in function call
	
	beq $s0,1,done		# this is the base case if $s0(n) = 1

	move $s1,$s0		# moving the value of the $s0 into $s1, means passing the parameter value to $s1
	
	li $t5,2		# now doing n%2 == 0 and updating the value of $s0 which is the parameter value of next function
	div $s1,$t5		# n%2
	mfhi $s3		# remainder is stored in $s3
	bne $s3,0,odd		# if remainder is not equal to zero jump to odd
	mflo $t1		# if even store the value of $s0 = n/2
	move $s0,$t1
	b collatz2
odd:
	mul $t0,$s0,3		# doing 3*n + 1 if it is odd
	add $t0,$t0,1
	move $s0,$t0		# passing the value to $s0
collatz2:	
	jal collatz		# jal to collatz

	addi $s2,$s2,1		# step ++

done:
	lw $ra,($sp)		# store the previous function address in $ra
	lw $s1,4($sp)		# store the value of function parameter in $s1
	addi $sp,$sp,8		# moving the stack forward by 8 bytes
	jr $ra			# jumping to return addrss

exit:
	li $v0,10		# system call for exit
	syscall	

##include <stdio.h>
#
#int step = 0;
#
#void collatz(int n){
#    if(n==1)return;
#    
#    if(n%2 == 0){
#        n = n/2;
#    }else{
#        n = 3*n + 1;
#    }
#    
#    collatz(n);
#    
#    step++;
#}
#
#
#int main(){
#    int n = 10;
#    collatz(n);
#    printf("%d",step);
#}