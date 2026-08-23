.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
# Exceptions:
#   - If you receive an fopen error or eof,
#     this function terminates the program with error code 27
#   - If you receive an fclose error or eof,
#     this function terminates the program with error code 28
#   - If you receive an fwrite error or eof,
#     this function terminates the program with error code 30
# ==============================================================================
write_matrix:
    # Save registers and reserve two words at 24(sp) and 28(sp) for the header.
    # The 32-byte frame preserves the required 16-byte stack alignment.
    addi sp, sp, -32
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)

    mv s1, a1                  # matrix pointer
    mv s2, a2                  # rows
    mv s3, a3                  # columns

    # Open the output file with write permissions.
    li a1, 1
    jal ra, fopen
    li t0, -1
    beq a0, t0, write_matrix_fopen_error
    mv s0, a0                  # file descriptor

    # Store rows and columns contiguously, then write two 4-byte items.
    sw s2, 24(sp)
    sw s3, 28(sp)
    mv a0, s0
    addi a1, sp, 24
    li a2, 2
    li a3, 4
    jal ra, fwrite
    li t0, 2
    bne a0, t0, write_matrix_fwrite_error

    # Write rows * columns matrix elements, each four bytes wide.
    mul s4, s2, s3
    mv a0, s0
    mv a1, s1
    mv a2, s4
    li a3, 4
    jal ra, fwrite
    bne a0, s4, write_matrix_fwrite_error

    # Close the file and require a successful return value of zero.
    mv a0, s0
    jal ra, fclose
    bne a0, x0, write_matrix_fclose_error

    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    addi sp, sp, 32
    jr ra

write_matrix_fopen_error:
    li a0, 27
    j exit

write_matrix_fclose_error:
    li a0, 28
    j exit

write_matrix_fwrite_error:
    li a0, 30
    j exit
