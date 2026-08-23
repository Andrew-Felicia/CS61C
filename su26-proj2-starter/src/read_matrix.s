.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
#   - If malloc returns an error,
#     this function terminates the program with error code 26
#   - If you receive an fopen error or eof,
#     this function terminates the program with error code 27
#   - If you receive an fclose error or eof,
#     this function terminates the program with error code 28
#   - If you receive an fread error or eof,
#     this function terminates the program with error code 29
# ==============================================================================
read_matrix:
    # Prologue: use a 32-byte frame to preserve 16-byte stack alignment.
    addi sp, sp, -32
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)

    mv s1, a1                  # address where rows must be stored
    mv s2, a2                  # address where columns must be stored

    # Open the file in read-only mode.
    li a1, 0
    jal ra, fopen
    li t0, -1
    beq a0, t0, read_matrix_fopen_error
    mv s0, a0                  # file descriptor

    # Read the 4-byte row count.
    mv a0, s0
    mv a1, s1
    li a2, 4
    jal ra, fread
    li t0, 4
    bne a0, t0, read_matrix_fread_error

    # Read the 4-byte column count.
    mv a0, s0
    mv a1, s2
    li a2, 4
    jal ra, fread
    li t0, 4
    bne a0, t0, read_matrix_fread_error

    # Allocate rows * columns * sizeof(int) bytes.
    lw t0, 0(s1)
    lw t1, 0(s2)
    mul t0, t0, t1
    slli s4, t0, 2             # matrix size in bytes

    mv a0, s4
    jal ra, malloc
    beq a0, x0, read_matrix_malloc_error
    mv s3, a0                  # allocated matrix pointer

    # Read all matrix elements into the allocated buffer.
    mv a0, s0
    mv a1, s3
    mv a2, s4
    jal ra, fread
    bne a0, s4, read_matrix_fread_error

    # Close the file. Any nonzero return value indicates failure.
    mv a0, s0
    jal ra, fclose
    bne a0, x0, read_matrix_fclose_error

    # Return the allocated matrix pointer.
    mv a0, s3

    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    addi sp, sp, 32
    jr ra

read_matrix_malloc_error:
    li a0, 26
    j exit

read_matrix_fopen_error:
    li a0, 27
    j exit

read_matrix_fclose_error:
    li a0, 28
    j exit

read_matrix_fread_error:
    li a0, 29
    j exit