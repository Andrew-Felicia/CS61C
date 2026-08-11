.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the number of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
argmax:
    # Prologue
    li t0 1
    blt a1, t0, error
    li t1 0   #i = 0
    
    li t2  0 #the return index
    


loop_start:
    bge t1 a1 loop_end


loop_continue:
    slli t3, t1, 2
    add t3, t3, a0
    lw t4 0(t3)
    


error:
    li a0 36
    j exit

loop_end:
    # Epilogue

    jr ra
