.data
    array:
        .word 0x00000134, 0x00000136, 0x00000120, 0x00000100, 0x00000002, 0x00000012, 0x00000010, 0x000000ff, 0x00000007, 0x00000001

.text
# Initialize registers to their register numbers
li x1, 1	#set register to its number
li x2, 2	#.
li x3, 3	#.
li x4, 4	#.
li x5, 5
li x6, 6
li x7, 7
li x8, 8
li x9, 9
li x10, 10
li x11, 11
li x12, 12
li x13, 13
li x14, 14
li x15, 15
li x16, 16
li x17, 17
li x18, 18
li x19, 19
li x20, 20
li x21, 21
li x22, 22
li x23, 23
li x24, 24
li x25, 25
li x26, 26
li x27, 27
li x28, 28
li x29, 29
li x30, 30
li x31, 31	#set register to its number

add   x0 , x0 , x0	#nop **initialization bubble sort
add   x31, x4 , x0	#$31 = 4
mul   x2 , x5 , x31	#j = 4 * items	
lui   x3, 0x10010	#load address base to $3
add  x2, x2, x3		#load last address
add   x0 , x0 , x0	#nop
BEGIN:	
lui	x3, 0x10010	#load address base
add   x3 , x3 , x0	
add   x4 , x3 , x31	#load first address 1 item
slt   x6 , x4 , x2	#compare if both address are equal
beq   x6 , x0 , CHECKER
LOAD:
lw    x13, 0(x3)	#load first data to reg x13
lw    x14, 0(x4)	#load consecutive data to reg x14
slt   x6 , x14, x13	#compare both numbers
beq   x6 , x0 , SKIP_SWAP#If not, go to swap
SWAP:
sw    x14, 0(x3)	#Swap data
sw    x13, 0(x4)
SKIP_SWAP:
add   x3 , x3 , x31	#add 4 to base address
add   x4 , x4 , x31	#add 4 second base address
slt   x6 , x4 , x2	#compare second address with last address
beq   x6 , x1 , LOAD	#if not, jump to load a new number
sub   x2 , x2 , x31	#sub last address - 4
j     BEGIN		#go to begin
CHECKER:
add   x0 , x0 , x0	#nop to start checker for first 5 items
lui	x26, 0x10010	#load base address for 1st item
add   x26, x26 , x0	
add   x27, x26, x31	#load address for second number
mul   x28, x5 , x31	#mult 4 * num items 0 last address
add   x28, x28, x26	#address x28 = fisrt item addr + last number addr
CHECKER_ITERATION:
lw    x29, 0(x26)	#load first number
lw    x30, 0(x27)	#load second number 
CHECKER_INFINITE_LOOP_COMPARE:
slt   x25, x30, x29	#compare if first < second (x25 = 0)
beq   x25, x0 , SKIP_INFINITE_LOOP # if x25 = 0, go to next compare
beq x0, x0,  CHECKER_INFINITE_LOOP_COMPARE
SKIP_INFINITE_LOOP:
add   x26, x26, x31	#add 4 1st base addr
add   x27, x27, x31	#add 4 2nd base addr
beq   x27, x28, NEXT_PROGRAM #is true after 4 comparisons
j CHECKER_ITERATION	#check next two pairs of numbers

NEXT_PROGRAM:
add   x0 , x0 , x0	#nop to start program
SELECTION_SORT_INITIALIZATION:
add   x0 , x0 , x0	#nop
add   x2 , x5 , x0	#set x2 with 5
add   x9 , x5 , x31	#add 4 + 5 
add   x10, x9 , x1	#add 9 +1
add   x6 , x0 , x0	#set x6 to 0
add   x3 , x5 , x0	#i = 5
SELECTION_SORT_START:
add   x4 , x3 , x1	#j= i +1
lui   x8, 0x10010	#load base address
mul   x13, x3 , x31	# j * 4
add  x13, x13, x8	#add base addr + addr first number
lw    x23, 0(x13)	#load 1st number
add   x12, x13, x0	#x12 = first number addr
add   x22, x23, x0	#x23 = fisrt number from memory
SELECTION_SORT_LOOP:
mul   x14, x4 , x31 	# j * 4	
add   x14, x14, x8	# add base addr to mul
lw    x24, 0(x14)	#load second number
slt   x6 , x24, x22	#compare if first number < sencond number
beq   x6 , x0 , SELECTION_SORT_SKIP 
add   x12, x14, x0	#swap addr
add   x22, x24, x0	#swap addr
SELECTION_SORT_SKIP:
add   x4 , x4 , x1	#j++
beq   x4 , x10, SELECTION_SORT_SWAP #(j = 10)
j SELECTION_SORT_LOOP 	#if not
SELECTION_SORT_SWAP:
add   x0 , x0 , x0	#nop
sw    x22, 0(x13)	#swap numbers, save in memory
sw    x23, 0(x12)
add   x3 , x3 , x1	#i++
add   x4 , x3 , x1	#j = i + 1
beq   x3 , x9 , SELECTION_SORT_CHECKER #(i==9)
j SELECTION_SORT_START	#if notset register to its number
SELECTION_SORT_CHECKER:
add   x0, x0, x0
