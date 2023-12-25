.data
message:
	.asciiz "Enter the number \n"

out:
	.asciiz "The sum of the series is:: "

check:
	.asciiz "The number entered is less than equal to zero 404 error \n"

.text
.globl main

#$s0 = n;
#$s1 = m;
#$s3 = retvalue
#s4 = i;

main:		# label main
	la $a0,message	# copying message address in $a0
	li $v0,4	
	syscall		# system call for printing
	
	li $v0,5	
	syscall		# system call for taking the input
	move $s0,$v0	# moving the value of n into $s0
	bgt $s0,0,main2	# doing sanitry check jump to main2 if value entered is greate than -1
	la $a0,check		
	li $v0,4
	syscall 		# system call for printing error message
	b main			# branching to main for retaking the input

main2:			
	jal sq_sum		# jump and link to sq_sum

	la $a0,out		#system call for printing output message
	li $v0,4
	syscall

	move $a0, $s3		# After the completing of recursive calling of sq_sum the returned value is stored in s3
	li $v0,1		# system call for printing of retured value $s3
	syscall
	b exit


sq_sum:
	subu $sp,$sp,8		# allocate 8 byte of memory
	sw $ra,($sp)		# storing the return address in ($sp)
	sw $s1,4($sp)		# storing the parameter passed in function call
	
	li $s3,0		# base case assigning $s3 =0 (return value)
	beq $s0,$zero,done	# check if the parameter passed is zero then jump to done
	
	move $s1,$s0		# moving the parameter passed in the function call to $s1
	sub $s0,$s0,1		# calculating the parameter for the next function call and stored in $s0
	jal sq_sum		# jal sq_sum

	li $s4,0		# $s4 is assigned as i which is zero
	move $s5,$s1		# copying the value of $s1 into $s5(temp)
	li $s1,1		# initialzing the sum to 1
	jal power		# jal power for calculating n^n
	add $s3,$s3,$s1		# adding it to returned value output

done:
	lw $ra,($sp)		# store the previous function address in $ra
	lw $s1,4($sp)		# store the value of function parameter in $s1
	addi $sp,$sp,8		# moving the stack forward by 8 bytes
	jr $ra			# jumping to return addrss

power:
	beq $s4,$s5,done_power	# loop check for i<n
	mul $s1,$s1,$s5		# sum = sum*m
	addi $s4,$s4,1		# i = i+1
	b power			# branch to power

done_power:
	jr $ra			# if the power calcualtion is done return to "add $s3,$s3,$s1"

exit:				# system call for exit
	li $v0,10
	syscall	
	
##include <stdio.h>
#
#int mul(int m){
#    if(n==0)return 0;
#    int num = fact(m-1);
#	int sum = 1;
#	for(int i=0;i<m;i++)sum *= m;
#	
#    return num + sum;
#}
#
#int main(){
#    int n;
#    printf("Enter the number \n");
#    scanf("%d",&n);
#    int ans = fact(n);
#    printf("%d", ans);
#}	
	