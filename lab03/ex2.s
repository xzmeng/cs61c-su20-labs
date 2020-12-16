.data
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
main:
    addi t0, x0, 0 # int k;
    addi s0, x0, 0 # int sum = 0;
    la s1, source  
    la s2, dest
loop:
    slli s3, t0, 2 # s3 = k *=4
    add t1, s1, s3 # t1 = &source[k]
    lw t2, 0(t1)   # t2 = source[k]
    beq t2, x0, exit # if (source[k] == 0) jump to exit
    add a0, x0, t2   # a0 = source[k]
    addi sp, sp, -8  # 
    sw t0, 0(sp)     # save register
    sw t2, 4(sp)     jal square
    lw t0, 0(sp)     # recover register
    lw t2, 4(sp)
    addi sp, sp, 8
    add t2, x0, a0 # t2 = result
    add t3, s2, s3 # t3 = &dest[k]
    sw t2, 0(t3)   # dest[k] = result
    add s0, s0, t2 # sum = sum + dest[k]
    addi t0, t0, 1 # k++
    jal x0, loop
square:
    add t0, a0, x0 # t0 = x
    add t1, a0, x0 # t1 = x
    addi t0, t0, 1 # t0 = x + 1
    addi t2, x0, -1 # t2 = -1
    mul t1, t1, t2 # t1 = -x
    mul a0, t0, t1 # a0 = (x + 1) * (-x)
    jr ra
exit:
    add a0, x0, s0 # a0 = sum
    add a1, x0, x0
    ecall # Terminate ecall
