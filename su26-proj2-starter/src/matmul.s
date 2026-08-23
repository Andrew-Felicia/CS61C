.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#   d = matmul(m0, m1)
# Arguments:
#   a0 (int*)  is the pointer to the start of m0
#   a1 (int)   is the # of rows (height) of m0
#   a2 (int)   is the # of columns (width) of m0
#   a3 (int*)  is the pointer to the start of m1
#   a4 (int)   is the # of rows (height) of m1
#   a5 (int)   is the # of columns (width) of m1
#   a6 (int*)  is the pointer to the the start of d
# Returns:
#   None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 38
# =======================================================



matmul:
    # Check m0, then m1, then compatibility, in the required order.
    li t0, 1
    blt a1, t0, matmul_error
    blt a2, t0, matmul_error
    blt a4, t0, matmul_error
    blt a5, t0, matmul_error
    bne a2, a4, matmul_error

    # Save every callee-saved register used below. The 48-byte frame keeps
    # the stack 16-byte aligned at the call to dot.
    addi sp, sp, -48
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)
    sw s7, 32(sp)
    sw s8, 36(sp)
    sw s9, 40(sp)

    mv s0, a0                  # base address of m0
    mv s1, a1                  # number of rows in m0
    mv s2, a2                  # shared dimension
    mv s3, a3                  # base address of m1
    mv s4, a5                  # number of columns in m1
    mv s5, a6                  # next destination address
    li s6, 0                   # row index
    mv s8, s0                  # pointer to current row of m0

matmul_outer_loop:
    bge s6, s1, matmul_done

    li s7, 0                   # column index
    mv s9, s3                  # pointer to current column's first element

matmul_inner_loop:
    bge s7, s4, matmul_next_row

    # dot(current row of m0, current column of m1,
    #     shared dimension, row stride 1, column stride m1_width)
    mv a0, s8
    mv a1, s9
    mv a2, s2
    li a3, 1
    mv a4, s4
    jal ra, dot

    sw a0, 0(s5)
    addi s5, s5, 4             # advance to next output element
    addi s9, s9, 4             # advance to next column of m1
    addi s7, s7, 1
    j matmul_inner_loop

matmul_next_row:
    slli t0, s2, 2             # bytes in one row of m0
    add s8, s8, t0
    addi s6, s6, 1
    j matmul_outer_loop

matmul_done:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    lw s9, 40(sp)
    addi sp, sp, 48
    jr ra

matmul_error:
    li a0, 38
    j exit

