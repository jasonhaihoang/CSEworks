#CSCE 2610 - Dr. Burke
#Homework #3 Part 1
#Jason Hoang
   
       .data 
alist: .word 17, 23, -7, 33, -13, 41, 53, -11
blist: .word 1023, 3529, -844, 5185, -927, -119, 3722
asize: .word 8
bsize: .word 7
msg1:  .asciiz "The Average of list A is "
msg2:  .asciiz "The Average of list B is about "
nwln:  .asciiz "\n"

   .text
main:

li $t2, 0	#set counter to 0
li $t4, 0	#set sum/average holder to 0
la $t1, alist	#load A list address
lw $t3, asize	#load A list size

lp1:
lw   $t0, ($t1)		#get A list
add  $t4, $t4, $t0	#add the A list variable to sum
addi $t1, $t1, 4	#move pointer in A list array to next int
addi $t2, $t2, 1	#increment loop counter by 1
blt  $t2, $t3, lp1	#rerun loop if counter < size

div $t4, $t4, $t3	#divide the sum by the size to get average

la $a0, msg1 
li $v0, 4 # set for print_string syscall 
syscall 
move $a0, $t4 # move avergae into a0 
li $v0, 34 # set for print_hex syscall 
syscall 
la $a0, nwln 
li $v0, 4 # set for print_string syscall 
syscall

li $t2, 0	#set counter to 0
li $t4, 0	#set sum/average holder to 0
la $t5, blist	#load B list address
lw $t6, bsize	#load B list size

lp2:
lw   $t0, ($t5)		#get B list
add  $t4, $t4, $t0	#add the B list variable to sum
addi $t5, $t5, 4	#move pointer in B list array to next int
addi $t2, $t2, 1	#increment loop counter by 1
blt  $t2, $t6, lp2	#rerun loop if counter < size

div $t4, $t4, $t6	#divide the sum by the size to get average

la $a0, msg2 
li $v0, 4 # set for print_string syscall 
syscall 
move $a0, $t4 # move average into a0 
li $v0, 34 # set for print_hex syscall 
syscall 
la $a0, nwln 
li $v0, 4 # set for print_string syscall 
syscall 
 
li $v0, 10 # set for exit syscall 
syscall 