#Ajay Kumar Dhakar(21CS30002)
#Gautam Kumar(21CS30020)
#Group no. 51


.data

arr:
	.space 400

num:
	.asciiz "Enter the number of integer \n"

all:
	.asciiz "Enter all integers\n"

maxi:
	.asciiz "Maximum sum is  "
#Conventions used or Alias
#$s0 = n
#$s1 = i
#$s3 = arr
#$s2 = j
#$s4 = sum
#$s5 = gl_sum
#$s6
.globl main 
.text

#maxlabel1 
maxlabel1:
	blt $s4,$s5,L5 		# comparing sum and gl_sum
	move $s5,$s4		# sum>gl_sum so storing sum in gl_sum
L5:
	jr $ra			# return to return address

#main function
main:					
	la $a0, num		# printing prompt 
	li $v0,4
	syscall			
		
	li $v0,5		# taking integer input from user and stored in $s0(n)
	syscall
	move $s0,$v0

	li $s1,0		# initializing the value of $s1(i) to zero
	la $s3,arr		# copying the address of arr in regsiter $s3
	
	la $a0,all		# pringint prompt
	li $v0,4
	syscall

	j loop1
				# loop1 for taking input from the user
loop1:
	beq $s1,$s0,L18		# loop condition i<n
	li $v0,5		# taking input from the user
	syscall
	sw $v0,($s3)		# storing the value into arr[i]

	addi $s3,$s3,4		# updating the addresso of $s3 to $s3 + 4
	addi $s1,$s1,1		# i = i + 1
	b loop1			# branch to loop1
				
L18:
	li $s1,0		#initializing the value of i =0
	la $s3,arr		# $s3 = arr
	li $s2,0		# j =0
	li $s4,0		# sum = 0
	li $s5,0		# glb_sum =0
	b loop2			# branch to loop2
			

# now initialising for loop as label loop2
loop2:
	beq $s1,$s0,L30 	# loop condition i<n

	mul $t0,$s1,4		# storing i*4 in $t0 for offset
	add $s6,$s3,$t0		# finding address of arr+i
	lw $s4,($s6)		# storing arr[i] in $s4
	
	move $s2,$s1		# j=i

	addi $s2,$s2,1
	div $s2,$s0
	mfhi $s2		# making j=(j+1)%n
	
	
	#for finding max
	jal maxlabel1		# maxlabel1 is called for storing max of sum and gl_sum in gl_sum

	b loop3

# now initialising while loop labeled as loop3
loop3:
	beq $s2,$s1,loop_before		# if j==i end loop 
	
	mul $t0,$s2,4			# multiplying j with 4 j = j*4
	add $s6,$s3,$t0			# $s6 = arr + j*4
	lw $t5,($s6)			# load the value at arr + j*4 in $t5
	add $s4,$s4,$t5	#line no.25	# sum = sum + arr[j]

	jal maxlabel1			# finding the max of sum and glb_sum


	addi $s2,$s2,1			# updating the value j = j + 1
	div $s2,$s0			
	mfhi $s2			# j = (j)%n
	b loop3				#branch to loop3

loop_before:
	add $s1,$s1,1			# updating the value of i to i + 1
	b loop2				# branch to loop2
L30:
	la $a0,maxi			# printing the prompt
	li $v0,4
	syscall

	move $a0,$s5			# copying the glb_sum into $a0
	li $v0,1			
	syscall				# system call for prining maximum global subarray sum

	li $v0,10			# end of the system call
	syscall

		
	
# Cprogram reference max function is  called and the return address is stored in the $ra rgister and jr $ra instruction will instruction just next to 'jal'
###include <stdio.h>
#
##int max(int a,int b){
##    if( a>b)return a;
##    else return b;
##}
##
##
##int main(){
##    int n;
##    scanf("%d",&n);
##    int arr[100];
##    for(int i=0;i<n;i++){
##        scanf("%d",arr + i);
##    }
##    
##    int sum =0;
##    int gl_ans =0;
##    for(int i=0;i<n;i++){
##        sum = arr[i];
##        gl_ans = max(gl_ans, sum);
##        int j=(i + 1)%n;
##        while(j%n != i){
##            sum = sum + arr[j];
##            gl_ans = max(gl_ans,sum);
##            j = (j+1)%n;
##            
##        }
##        
##    }
##    printf("%d",gl_ans);
##    
##}
	
	