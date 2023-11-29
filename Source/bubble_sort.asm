.data
    array:
        .word 3, 5, 4, 1, 2, 2, 1, 4, 3, 5

.text
    .globl _start
_start:

    # Initialize registers to their register numbers
    li x1, 1
    li x2, 2
    li x3, 3
    li x4, 4
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
    li x31, 31

add   x0 , x0 , x0
add   x31, x4 , x0
mul   x2 , x5 , x31
lui   x3, 0x10010
add  x2, x2, x3
add   x0 , x0 , x0

BEGIN:
lui	x3, 0x10010
add   x3 , x3 , x0
add   x4 , x3 , x31
slt   x6 , x4 , x2
beq   x6 , x0 , CHECKER

LOAD:
lw    x13, 0(x3)
lw    x14, 0(x4)
slt   x6 , x14, x13
beq   x6 , x0 , SKIP_SWAP

SWAP:
sw    x14, 0(x3)
sw    x13, 0(x4)

SKIP_SWAP:
add   x3 , x3 , x31
add   x4 , x4 , x31

slt   x6 , x4 , x2
beq   x6 , x1 , LOAD
sub   x2 , x2 , x31
j     BEGIN

CHECKER:
add   x0 , x0 , x0
lui	x26, 0x10010
add   x26, x26 , x0
add   x27, x26, x31
mul   x28, x5 , x31

add   x28, x28, x26
CHECKER_ITERATION:
lw    x29, 0(x26)
lw    x30, 0(x27)
CHECKER_INFINITE_LOOP_COMPARE:
slt   x25, x30, x29

beq   x25, x0 , SKIP_INFINITE_LOOP
beq   x0 , x0 , CHECKER_INFINITE_LOOP_COMPARE
SKIP_INFINITE_LOOP:
add   x26, x26, x31
add   x27, x27, x31

beq   x27, x28, NEXT_PROGRAM
beq   x0 , x0 , CHECKER_ITERATION

NEXT_PROGRAM:
add   x0 , x0 , x0

SELECTION_SORT_INITIALIZATION:
add   x0 , x0 , x0
add   x2 , x5 , x0
add   x9 , x5 , x31
add   x10, x9 , x1

add   x6 , x0 , x0
add   x3 , x5 , x0
SELECTION_SORT_START:
add   x4 , x3 , x1
lui   x8, 0x10010
mul   x13, x3 , x31
add  x13, x13, x8

lw    x23, 0(x13)
add   x12, x13, x0
add   x22, x23, x0
SELECTION_SORT_LOOP:
mul   x14, x4 , x31 #4
add   x14, x14, x8

lw    x24, 0(x14)
slt   x6 , x24, x22
beq   x6 , x0 , SELECTION_SORT_SKIP
add   x12, x14, x0

add   x22, x24, x0
SELECTION_SORT_SKIP:
add   x4 , x4 , x1
beq   x4 , x10, SELECTION_SORT_SWAP
beq   x0 , x0 , SELECTION_SORT_LOOP

SELECTION_SORT_SWAP:
add   x0 , x0 , x0
sw    x22, 0(x13)
sw    x23, 0(x12)
add   x3 , x3 , x1

add   x4 , x3 , x1
beq   x3 , x9 , SELECTION_SORT_CHECKER
beq   x0 , x0 , SELECTION_SORT_START

SELECTION_SORT_CHECKER:
