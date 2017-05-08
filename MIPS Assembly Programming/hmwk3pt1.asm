#CSCE 2610 - Dr. Burke
#Homework #3 Part 1
#Jason Hoang
   
   .data 
a: .word 0x47bdc76e 
b: .word 0x763f6bea 
c: .word 0xf369bed7 
d: .word 0x00cafe42 
msg1:  .asciiz "The value of h is "
msg2:  .asciiz "The value of i is "
nwln:  .asciiz "\n"
 
 
   .text 
main:
la $s0, a		#get address for a, the base
lw $s1, 0($s0)		#set address for a
lw $s2, 4($s0)		#set for b
lw $s3, 8($s0)		#set for c
lw $s4, 12($s0)		#setc for d

and $s6, $s1, $s2	#(a & b)
or  $t0, $s3, $s4	#(c | d)
xor $s6, $s6, $t0	#((a & b) ^ (c | d))
srl $s6, $s6, 3		#(((a & b) ^ (c | d)) >> 3)

xor $s7, $s1, $s3	#(a ^ c)
and $s7, $s7, $s2	#((a ^ c) & b)
sll $t1, $s4, 5		#(d << 5)
or  $s7, $s7, $t1	#(((a ^ c) & b) | (d << 5))


la $a0, msg1 
li $v0, 4 # set for print_string syscall 
syscall 
move $a0, $s6 # move h into a0 
li $v0, 34 # set for print_hex syscall 
syscall 
la $a0, nwln 
li $v0, 4 # set for print_string syscall 
syscall 
 
la $a0, msg2 
li $v0, 4 # set for print_string syscall 
syscall 
move $a0, $s7 # move i into a0 
li $v0, 34 # set for print_hex syscall 
syscall 
la $a0, nwln 
li $v0, 4 # set for print_string syscall 
syscall 
 
li $v0, 10 # set for exit syscall 
syscall 
