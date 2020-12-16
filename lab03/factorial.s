.globl factorial

.data
n: .word 8

.text
main:
    la t0, n     # t0 = &n
    lw a0, 0(t0) # a0 = 8
    jal ra, factorial  # save ra on stack , goto factorial 

    addi a1, a0, 0  
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    add t0, a0, x0 # t0 = n
    addi a0, x0, 1 # a0 = 1
loop:
    bge x0, t0, ret
    mul a0, a0, t0
    addi t0, t0, -1
    jal x0, loop

ret:
    jr ra
    
