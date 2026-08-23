.globl classify

.text
# =====================================
# COMMAND LINE ARGUMENTS
# =====================================
# Args:
#   a0 (int)        argc
#   a1 (char**)     argv
#   a1[1] (char*)   pointer to the filepath string of m0
#   a1[2] (char*)   pointer to the filepath string of m1
#   a1[3] (char*)   pointer to the filepath string of input matrix
#   a1[4] (char*)   pointer to the filepath string of output file
#   a2 (int)        silent mode, if this is 1, you should not print
#                   anything. Otherwise, you should print the
#                   classification and a newline.
# Returns:
#   a0 (int)        Classification
# Exceptions:
#   - If there are an incorrect number of command line args,
#     this function terminates the program with exit code 31
#   - If malloc fails, this function terminates the program with exit code 26
#
# Usage:
#   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>
classify:
    # argc includes the program name, so exactly five arguments are required.
    li t0, 5
    bne a0, t0, classify_argc_error

    # Stack layout:
    #   0..32  saved ra and s0-s7
    #   40     m0 rows
    #   44     m0 columns
    #   48     m1 rows
    #   52     m1 columns
    #   56     input rows
    #   60     input columns
    addi sp, sp, -64
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)
    sw s7, 32(sp)

    mv s0, a1                  # argv
    mv s1, a2                  # silent flag

    # Read pretrained matrix m0.
    lw a0, 4(s0)
    addi a1, sp, 40
    addi a2, sp, 44
    jal ra, read_matrix
    mv s2, a0                  # m0 data

    # Read pretrained matrix m1.
    lw a0, 8(s0)
    addi a1, sp, 48
    addi a2, sp, 52
    jal ra, read_matrix
    mv s3, a0                  # m1 data

    # Read the input matrix.
    lw a0, 12(s0)
    addi a1, sp, 56
    addi a2, sp, 60
    jal ra, read_matrix
    mv s4, a0                  # input data

    # Allocate h. Its dimensions are m0_rows by input_columns.
    lw t0, 40(sp)
    lw t1, 60(sp)
    mul t0, t0, t1
    slli a0, t0, 2
    jal ra, malloc
    beq a0, x0, classify_malloc_error
    mv s5, a0                  # h data

    # h = matmul(m0, input)
    mv a0, s2
    lw a1, 40(sp)
    lw a2, 44(sp)
    mv a3, s4
    lw a4, 56(sp)
    lw a5, 60(sp)
    mv a6, s5
    jal ra, matmul

    # Apply ReLU to all elements of h in place.
    mv a0, s5
    lw t0, 40(sp)
    lw t1, 60(sp)
    mul a1, t0, t1
    jal ra, relu

    # Allocate o. Its dimensions are m1_rows by input_columns.
    lw t0, 48(sp)
    lw t1, 60(sp)
    mul t0, t0, t1
    slli a0, t0, 2
    jal ra, malloc
    beq a0, x0, classify_malloc_error
    mv s6, a0                  # o data

    # o = matmul(m1, h)
    mv a0, s3
    lw a1, 48(sp)
    lw a2, 52(sp)
    mv a3, s5
    lw a4, 40(sp)
    lw a5, 60(sp)
    mv a6, s6
    jal ra, matmul

    # Write o with dimensions m1_rows by input_columns.
    lw a0, 16(s0)
    mv a1, s6
    lw a2, 48(sp)
    lw a3, 60(sp)
    jal ra, write_matrix

    # Find the index of the largest output element.
    mv a0, s6
    lw t0, 48(sp)
    lw t1, 60(sp)
    mul a1, t0, t1
    jal ra, argmax
    mv s7, a0                  # preserve classification across later calls

    # Print only when silent mode is zero.
    bne s1, x0, classify_skip_print
    mv a0, s7
    jal ra, print_int
    li a0, '\n'
    jal ra, print_char

classify_skip_print:
    # Free the three input matrices and both intermediate/output matrices.
    mv a0, s2
    jal ra, free
    mv a0, s3
    jal ra, free
    mv a0, s4
    jal ra, free
    mv a0, s5
    jal ra, free
    mv a0, s6
    jal ra, free

    # Return the classification and restore the caller's saved registers.
    mv a0, s7
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    addi sp, sp, 64
    jr ra

classify_malloc_error:
    li a0, 26
    j exit

classify_argc_error:
    li a0, 31
    j exit