.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the number of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
    # Prologue
    li t0 1
    blt a1, t0, error
    
    li t1 0  #i = 0
    


loop_start:
    bge t1, a1, loop_end



loop_continue:
    slli t2, t1, 2 # t2 = i * 4, t2 is the absolute offset value.
    add t2, t2, a0 
    lw t3 0(t2)
    bge t3, zero, skip_zero
    li t3 0
    
skip_zero:
    sw t3 0(t2)        #why, why we need to put it back, t2 already has the value, we copy from t2.
    addi t1, t1, 1     #because, these labels' logic are so connected to each other, and it's made by claude code.
    j loop_start
    
    


error:
    li a0 36
    j exit

loop_end:
    # Epilogue
    jr ra
