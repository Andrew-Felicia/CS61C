# Task 6: ADD operand and boundary cases.
# Expected destination values after each instruction, in RV32 hexadecimal.
# Uses only Task 5 setup instructions and the Task 6 instructions named here.
# The course integration harness supplies pass/fail comparisons.

# Case 1: rs1 = 0x00000000, rs2 = 0x00000000.
addi t0, x0, 0            # t0 = 0x00000000
addi t1, x0, 0            # t1 = 0x00000000
add t2, t0, t1            # t2 = 0x00000000

# Case 2: rs1 = 0x00000025, rs2 = 0x0000000c.
addi t0, x0, 37           # t0 = 0x00000025
addi t1, x0, 12           # t1 = 0x0000000c
add t2, t0, t1            # t2 = 0x00000031

# Case 3: rs1 = 0x0000000c, rs2 = 0x00000025.
addi t0, x0, 12           # t0 = 0x0000000c
addi t1, x0, 37           # t1 = 0x00000025
add t2, t0, t1            # t2 = 0x00000031

# Case 4: rs1 = 0xffffffff, rs2 = 0x00000001.
addi t0, x0, -1           # t0 = 0xffffffff
addi t1, x0, 1            # t1 = 0x00000001
add t2, t0, t1            # t2 = 0x00000000

# Case 5: rs1 = 0xfffffff1, rs2 = 0xfffffff9.
addi t0, x0, -15          # t0 = 0xfffffff1
addi t1, x0, -7           # t1 = 0xfffffff9
add t2, t0, t1            # t2 = 0xffffffea

# Case 6: rs1 = 0x7fffffff, rs2 = 0x00000001.
addi t0, x0, 511          # t0 = 0x000001ff
slli t0, t0, 11           # t0 = 0x000ff800
addi t0, t0, 2047         # t0 = 0x000fffff
slli t0, t0, 11           # t0 = 0x7ffff800
addi t0, t0, 2047         # t0 = 0x7fffffff
addi t1, x0, 1            # t1 = 0x00000001
add t2, t0, t1            # t2 = 0x80000000

# Case 7: rs1 = 0x80000000, rs2 = 0x00000001.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t1, x0, 1            # t1 = 0x00000001
add t2, t0, t1            # t2 = 0x80000001

# Case 8: rs1 = 0x80000000, rs2 = 0xffffffff.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t1, x0, -1           # t1 = 0xffffffff
add t2, t0, t1            # t2 = 0x7fffffff

# Case 9: rs1 = 0x80000000, rs2 = 0x80000000.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t1, x0, 512          # t1 = 0x00000200
slli t1, t1, 11           # t1 = 0x00100000
slli t1, t1, 11           # t1 = 0x80000000
add t2, t0, t1            # t2 = 0x00000000

# Case 10: rs1 = 0xffffffff, rs2 = 0xffffffff.
addi t0, x0, -1           # t0 = 0xffffffff
addi t1, x0, -1           # t1 = 0xffffffff
add t2, t0, t1            # t2 = 0xfffffffe

# Destination aliases rs1, then rs2; consume each result immediately.
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
add t0, t0, t1            # t0 = 0xfffffffc
addi s0, t0, 0            # s0 = 0xfffffffc
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
add t1, t0, t1            # t1 = 0xfffffffc
addi s0, t1, 0            # s0 = 0xfffffffc

# Both read ports select the same source register.
addi t0, x0, -3           # t0 = 0xfffffffd
add t2, t0, t0            # t2 = 0xfffffffa
