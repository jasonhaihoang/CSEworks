#########################################################################################################
#
#  CSCE 2610 Spring 2015, Project 1 - Due March 8, 11:59 pm
#  Doubly linked list processing initialization data
#  Dr. Burke
#
#	This program is mostly translated from the project.c file given.
#	The program will add all of the given nodes to a doubly linked circular list and sort them in order from least key value to greatest.
#	The program will then print all of the addresses and keys for each node.
#	The program then finds the key value which is to be deleted and then passes that value to the remove function that basically unlinks the nodes from the list.
#	After removing the two unwanted nodes, the program finds the smallest key value and then prints the strings within each node in the correct order.
#	This program utilizes the pointers and function operations within MIPS to mimic the C program as close as possible.
#
#	Code written and tested by: Jason Hoang
#	Collaboration with: Jake Donnelly and Jacob Seiz
#
#########################################################################################################

	.data
newln:	.asciiz	"\n"		# new line string
first:	.word	0		# header = NULL

itmaddress:	.asciiz "Item Address: "
itmnext:	.asciiz "Itm->next: "
itmprev:	.asciiz "Itm->prev: "
itmkey:		.asciiz	"Itm->key: "

	.align	4		# force word alignment
itm1:
	.word	0		# next
	.word	0		# prev
	.word	277		# key
	.asciiz	" language can be used for time"

	.align	4		# force word alignment
itm2:
	.word	0		# next
	.word	0		# prev
	.word	107		# key
	.asciiz	"gramming productivity is great"

	.align	4		# force word alignment
itm3:
	.word	0		# next
	.word	0		# prev
	.word	313		# key
	.asciiz	"-critical or space-\ncritical"

	.align	4		# force word alignment
itm4:
	.word	0		# next
	.word	0		# prev
	.word	617		# key
	.asciiz	"ized fields.  8>)\n"

	.align	4		# force word alignment
itm5:
	.word	0		# next
	.word	0		# prev
	.word	376		# key
	.asciiz	" i do not belong in the text "

	.align	4		# force word alignment
itm6:
	.word	0		# next
	.word	0		# prev
	.word	7		# key
	.asciiz	"The use of assembly language p"

	.align	4		# force word alignment
itm7:
	.word	0		# next
	.word	0		# prev
	.word	163		# key
	.asciiz	"ly enhanced by using high-lev"

	.align	4		# force word alignment
itm8:
	.word	0		# next
	.word	0		# prev
	.word	41		# key
	.asciiz	"d time-consuming process.\nPro"

	.align	4		# force word alignment
itm9:
	.word	0		# next
	.word	0		# prev
	.word	295		# key
	.asciiz	" i do not belong in the text "

	.align	4		# force word alignment
itm10:
	.word	0		# next
	.word	0		# prev
	.word	523		# key
	.asciiz	"et specific needs and constrain"

	.align	4		# force word alignment
itm11:
	.word	0		# next
	.word	0		# prev
	.word	11		# key
	.asciiz	"rogramming is a difficult an"

	.align	4		# force word alignment
itm12:
	.word	0		# next
	.word	0		# prev
	.word	599		# key
	.asciiz	"ts within these special"

	.align	4		# force word alignment
itm13:
	.word	0		# next
	.word	0		# prev
	.word	431		# key
	.asciiz	"ed program is\nrequired to me"

	.align	4		# force word alignment
itm14:
	.word	0		# next
	.word	0		# prev
	.word	331		# key
	.asciiz	" embedded applications where a"

	.align	4		# force word alignment
itm15:
	.word	0		# next goes to itm7
	.word	0		# prev goes to itm8
	.word	233		# key value
	.asciiz	" application field.  Assembly"

	.align	4		# force word alignment
itm16:
	.word	0		# next
	.word	0		# prev
	.word	181		# key
	.asciiz	"el languages tailored\nto the"

	.align	4		# force word alignment
itm17:
	.word	0		# next
	.word	0		# prev
	.word	401		# key
	.asciiz	"bsolute control of the generat"
	
	
	.text
main:

jal 	addItem				# create doubly linked list
jal	printList			# Prints the Keys within the List
li	$s1, 295			# set $s1 as the value being removed
jal	findItem			# finds the address of $s1
jal	removeItem			# Un-links the node being removed
li	$s1, 376			# set $s1 as the value being removed
jal	findItem			# finds the address of $s1
jal	removeItem			# Un-links the node being removed
jal	findSmall			# finds the address of the smallest key
jal 	printData			# print list strings
#jal	printList			# Use this to see the values and addresses again after removing
jal	ENDprogram			# Ends Program

#################### ADD ITEM FUNCTION ####################
addItem:
sw	$ra, 4($sp)			# store first return address

la 	$s0, itm1			# Center node
la	$s2, itm2			# 1st node added - itm2

sw	$s0, first			# store Center Node
move	$s1, $s0			# Hold center node address in $s1

lw	$s5, 8($s1)			# Load keys into comparing register to be sorted
lw	$s6, 8($s2)
jal	sort				# jump to sort function

la	$s2, itm3			# load itm3 address
lw	$s5, 8($s0)			# get value of Center node
lw	$s6, 8($s2)			# get value of NEWitm
jal	sort				# sort low to high

la	$s2, itm4			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

la	$s2, itm5			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

la	$s2, itm6			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

la	$s2, itm7			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

la	$s2, itm8			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

la	$s2, itm9			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

la	$s2, itm10			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

la	$s2, itm11			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

la	$s2, itm12			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

la	$s2, itm13			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

la	$s2, itm14			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

la	$s2, itm15			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

la	$s2, itm16			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

la	$s2, itm17			# repeat linking and sorting process for each itm
lw	$s5, 8($s0)
lw	$s6, 8($s2)
jal	sort

### This block LINKS the ends of the list to form the Circular Doubly Linked List
lw	$s5, 0($s0)				# starting pointers
lw	$s6, 0($s0)
LEnd:
	beqz	$s5, REnd			# if not at the Left End of the list
	move	$s3, $s5			# save previous node address
	lw	$s5, 4($s5)			# move pointer one node to the Left
	b	LEnd				# loop
REnd:
	beqz	$s6, Connect			# same process for the Right End
	move	$s4, $s6
	lw	$s6, 0($s6)
	b	REnd
Connect:					# connect the Ends
	sw	$s4, 4($s3)			# Right to Left
	sw	$s3, 0($s4)			# Left to Right
	lw	$ra, 4($sp)			# load main: return address
	jr	$ra				# return
### END of Linking the ends of the list

	### Sorts the nodes being added into the list from lowest key value to highest
	sort:
		move	$s1, $s0		# set temporary holder for center node to traverse
		blt	$s6, $s5, less		# sort if key is less than center
		bgt	$s6, $s5, greater	# sort if key is greater than center

	less:
		bgt	$s6, $s5, endif1	# if the prev node key is less than the new node key, add node here
		move	$s4, $s1		# set temporary holder for previous node
		lw	$s1, 4($s1)		# load prev and test greater than
		beqz	$s1, addEndL		# if at end of list, add new node to the end
		lw	$s5, 8($s1)		# get value of prev
		b	less			# loop

	greater:
		blt	$s6, $s5, endif2	# if the next node key is greater than the new node key, add node here
		move	$s4, $s1		# set temporary holder for previous node
		lw	$s1, 0($s1)		# load next and test less than
		beqz	$s1, addEndG		# if at end of list, add new node to the end
		lw	$s5, 8($s1)		# get value of next
		b	greater			# loop

	endif1:					# RIGHT of $s1
		lw	$s4, 0($s1)		# load address of the previous node's ->next
		sw	$s2, 0($s1)		# store address of NEWitm into $s1->next
		sw	$s2, 4($s4)		# store address of NEWitm into $s1->next->prev
		sw	$s1, 4($s2)		# store address of $s1 into NEWitm->prev
		sw	$s4, 0($s2)		# store address of $s1->next into NEWitm->next
		jr	$ra
																								
	endif2:					# LEFT of $s1
		lw	$s4, 4($s1)		# load address of the previous node's ->prev
		sw	$s2, 4($s1)		# store address of NEWitm into $s1->prev
		sw	$s2, 0($s4)		# store address of NEWitm into $s1->prev->next
		sw	$s1, 0($s2)		# store address of $s1 into NEWitm->next
		sw	$s4, 4($s2)		# store address of $s1->prev into NEWitm->prev
		jr	$ra

	addEndL:				# LEFT SIDE END
		sw	$s2, 4($s4)		# store NEWitm address into ENDitm->prev
		sw	$s4, 0($s2)		# store ENDitm address into NEWitm->next
		jr	$ra

	addEndG:				# RIGHT SIDE END
		sw	$s2, 0($s4)		# store NEWitm address into ENDitm->next
		sw	$s4, 4($s2)		# store ENDitm address into NEWitm->prev
		jr	$ra
	### END of sorting block
	
#################### REMOVE ITEM FUNCTION ####################	
removeItem:
lw 	$t1, 0($a1)        		#itm->next
bne 	$t1, $a1, setHead    		#if itm->next == itm
li 	$v0, 0        			#new_hdr = NULL
b 	removeDone

setHead:
move 	$v0, $t1        		#new_hdr = itm->next

removeDone:
lw 	$t2, 4($a1)        		#itm->prev
sw 	$t1, 0($t2)        		#itm->prev = itm->prev->next
sw 	$t2, 4($t1)        		#itm->prev = itm->next->prev
sw 	$0, ($a1)        		#itm->next = NULL
sw 	$0, 4($a1)        		#itm->prev = NULL
jr 	$ra        			#return to main

#################### FIND ITEM FUNCTION ####################
findItem:
lw	$s0, first			# load center node to traverse
lw	$s7, 8($s0)			# get value of node	

loop:
beq	$s7, $s1, findDone		# stops searaching and returns
lw	$s0, 0($s0)			# move pointer to next node
lw	$s7, 8($s0)			# load next key
b	loop				# loop

findDone:
move	$a1, $s0			# store the address of the found item to be returned
jr	$ra

#################### FIND SMALL FUNCTION ####################
findSmall:
lw	$s0, first			# load center node to traverse
lw	$s5, 8($s0)			# get value of node
lw	$s0, 4($s0)			# move pointer to next node	
lw	$s6, 8($s0)			# get value of node

smallLoop:
bgt	$s6, $s5, smallDone		# stops searching and returns
move	$s5, $s6			# move lower key in $s5 in oreder to load the next key down the list
lw	$s0, 4($s0)			# move pointer to next->prev node
lw	$s6, 8($s0)			# load prev key
b	smallLoop				# loop

smallDone:
lw	$a2, 0($s0)			# store the address of the found item to be returned
jr	$ra

#################### PRINT DATA FUNCTION ####################
printData:
move	$s1, $a2			# load address of the smallest key
move	$s7, $a2			# backup address to stop loop	
la	$a0, 12($s1)			# load key from first node
li 	$v0, 4				# print_int system call
syscall					

lw	$s1, 0($s1)			# Load itm->next address

dataLoop:
beq	$s7, $s1, dataDone		# stops printing at the end of the list
la	$a0, 12($s1)			# get itm->next key
li 	$v0, 4
syscall

lw	$s1, 0($s1)			# move pointer to next node
b	dataLoop			# loop

dataDone:
la	$a0, newln			# get address of new line string
li	$v0, 4				# print_string system call
syscall
jr	$ra				# return to main

#################### PRINT LIST FUNCTION ####################
printList:
lw	$s0, first			# load center node to traverse
lw	$s7, first			# backup center node to stop loop	

la	$a0, itmaddress			# get address of item address string
li	$v0, 4				# print_string system call
syscall
move	$a0, $s0			# load address from first node
li 	$v0, 34				# print_hex system call
syscall					

la	$a0, newln			# get address of new line string
li	$v0, 4				# print_string system call
syscall

la	$a0, itmnext			# get address of item next string
li	$v0, 4				# print_string system call
syscall
lw	$a0, 0($s0)			# load address from itm->next node
li 	$v0, 34				# print_hex system call
syscall					

la	$a0, newln			# get address of new line string
li	$v0, 4				# print_string system call
syscall

la	$a0, itmprev			# get address of item prev string
li	$v0, 4				# print_string system call
syscall
lw	$a0, 4($s0)			# load address from itm->prev node
li 	$v0, 34				# print_hex system call
syscall					

la	$a0, newln			# get address of new line string
li	$v0, 4				# print_string system call
syscall

la	$a0, itmkey			# get address of item key string
li	$v0, 4				# print_string system call
syscall
lw	$a0, 8($s0)			# load key from first node
li 	$v0, 1				# print_int system call
syscall					

la	$a0, newln			# get address of new line string
li	$v0, 4				# print_string system call
syscall
la	$a0, newln			# get address of new line string
li	$v0, 4				# print_string system call
syscall

lw	$s0, 0($s0)			# Load itm->next address

listLoop:
beq	$s7, $s0, listDone			# stops printing at the end of the list

la	$a0, itmaddress			# get address of item address string
li	$v0, 4				# print_string system call
syscall
move	$a0, $s0			# load address from next node
li 	$v0, 34				# print_hex system call
syscall					

la	$a0, newln			# get address of new line string
li	$v0, 4				# print_string system call
syscall

la	$a0, itmnext			# get address of item next string
li	$v0, 4				# print_string system call
syscall
lw	$a0, 0($s0)			# load address from itm->next node
li 	$v0, 34				# print_hex system call
syscall					

la	$a0, newln			# get address of new line string
li	$v0, 4				# print_string system call
syscall

la	$a0, itmprev			# get address of item prev string
li	$v0, 4				# print_string system call
syscall
lw	$a0, 4($s0)			# load address from itm->prev node
li 	$v0, 34				# print_hex system call
syscall					

la	$a0, newln			# get address of new line string
li	$v0, 4				# print_string system call
syscall

la	$a0, itmkey			# get address of item key string
li	$v0, 4				# print_string system call
syscall
lw	$a0, 8($s0)			# load key from next node
li 	$v0, 1				# print_int system call
syscall					

la	$a0, newln			# get address of new line string
li	$v0, 4				# print_string system call
syscall
la	$a0, newln			# get address of new line string
li	$v0, 4				# print_string system call
syscall

lw	$s0, 0($s0)			# move pointer to next node
b	listLoop			# loop

listDone:
la	$a0, newln			# get address of new line string
li	$v0, 4				# print_string system call
syscall
jr	$ra				# return to main

#################### END PROGRAM ####################
ENDprogram:
li	$v0, 10				# system call code for exit = 10
syscall					# call operating sys
