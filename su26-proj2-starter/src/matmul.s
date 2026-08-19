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


#paramter:
# t0: outer loop counter
# t1: inner loop counter
# t3: the size of the result array.
# t4: the insert index to result array.


matmul:

    # Error checks
    li t0 1
    blt a1 t0 error
    blt a2 t0 error
    blt a4 t0 error
    blt a5 t0 error
    bne a2 a4 error


    # Prologue
    mul t3 a1 a5 # t3:the size of the result array
    mv t0 a1 # t0 is the outer loop counter.
    li t4 0

    j outer_loop_start

error:
    li a0 38
    j exit

outer_loop_start:
    bge x0 t0 outer_loop_end
    mv t1 a5 # t1 is the inner loop counter.


inner_loop_start:
    bge x0 t1 inner_loop_end
    addi t1 t1 -1

    #store value before call other functions.
    addi sp sp -20
    sw a0 0(sp)
    sw a1 4(sp)
    sw a2 8(sp)
    sw a3 12(sp)
    sw a4 16(sp)

    #prepare arguments for function dot.
    mv a1 a3
    li a3 1
    mv a4 a5

    jal ra dot

    sw a0 0(a6)

    #restore value after call other functions.
    lw a0 0(sp)
    lw a1 4(sp)
    lw a2 8(sp)
    lw a3 12(sp)
    lw a4 16(sp)
    addi sp sp 20

    j inner_loop_start

inner_loop_end:
    j outer_loop_start



outer_loop_end:
    # Epilogue
    jr ra
