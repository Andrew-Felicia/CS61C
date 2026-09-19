# Task 6: SLT operand and boundary cases.
# Expected destination values after each instruction, in RV32 hexadecimal.
# Uses only Task 5 setup instructions and the Task 6 instructions named here.
# The course integration harness supplies pass/fail comparisons.

# Case 1: rs1 = 0x00000000, rs2 = 0x00000000.
addi t0, x0, 0            # t0 = 0x00000000
addi t1, x0, 0            # t1 = 0x00000000
slt t2, t0, t1            # t2 = 0x00000000

# Case 2: rs1 = 0x00000001, rs2 = 0x00000002.
addi t0, x0, 1            # t0 = 0x00000001
addi t1, x0, 2            # t1 = 0x00000002
slt t2, t0, t1            # t2 = 0x00000001

# Case 3: rs1 = 0x00000002, rs2 = 0x00000001.
addi t0, x0, 2            # t0 = 0x00000002
addi t1, x0, 1            # t1 = 0x00000001
slt t2, t0, t1            # t2 = 0x00000000

# Case 4: rs1 = 0xffffffff, rs2 = 0x00000000.
addi t0, x0, -1           # t0 = 0xffffffff
addi t1, x0, 0            # t1 = 0x00000000
slt t2, t0, t1            # t2 = 0x00000001

# Case 5: rs1 = 0x00000000, rs2 = 0xffffffff.
addi t0, x0, 0            # t0 = 0x00000000
addi t1, x0, -1           # t1 = 0xffffffff
slt t2, t0, t1            # t2 = 0x00000000

# Case 6: rs1 = 0xfffffffe, rs2 = 0xffffffff.
addi t0, x0, -2           # t0 = 0xfffffffe
addi t1, x0, -1           # t1 = 0xffffffff
slt t2, t0, t1            # t2 = 0x00000001

# Case 7: rs1 = 0xffffffff, rs2 = 0xfffffffe.
addi t0, x0, -1           # t0 = 0xffffffff
addi t1, x0, -2           # t1 = 0xfffffffe
slt t2, t0, t1            # t2 = 0x00000000

# Case 8: rs1 = 0x80000000, rs2 = 0x7fffffff.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t1, x0, 511          # t1 = 0x000001ff
slli t1, t1, 11           # t1 = 0x000ff800
addi t1, t1, 2047         # t1 = 0x000fffff
slli t1, t1, 11           # t1 = 0x7ffff800
addi t1, t1, 2047         # t1 = 0x7fffffff
slt t2, t0, t1            # t2 = 0x00000001

# Case 9: rs1 = 0x7fffffff, rs2 = 0x80000000.
addi t0, x0, 511          # t0 = 0x000001ff
slli t0, t0, 11           # t0 = 0x000ff800
addi t0, t0, 2047         # t0 = 0x000fffff
slli t0, t0, 11           # t0 = 0x7ffff800
addi t0, t0, 2047         # t0 = 0x7fffffff
addi t1, x0, 512          # t1 = 0x00000200
slli t1, t1, 11           # t1 = 0x00100000
slli t1, t1, 11           # t1 = 0x80000000
slt t2, t0, t1            # t2 = 0x00000000

# Case 10: rs1 = 0x80000000, rs2 = 0x00000001.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t1, x0, 1            # t1 = 0x00000001
slt t2, t0, t1            # t2 = 0x00000001

# Case 11: rs1 = 0x00000001, rs2 = 0x80000000.
addi t0, x0, 1            # t0 = 0x00000001
addi t1, x0, 512          # t1 = 0x00000200
slli t1, t1, 11           # t1 = 0x00100000
slli t1, t1, 11           # t1 = 0x80000000
slt t2, t0, t1            # t2 = 0x00000000

# Case 12: rs1 = 0x80000000, rs2 = 0x80000000.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t1, x0, 512          # t1 = 0x00000200
slli t1, t1, 11           # t1 = 0x00100000
slli t1, t1, 11           # t1 = 0x80000000
slt t2, t0, t1            # t2 = 0x00000000

# Destination aliases rs1, then rs2; consume each result immediately.
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
slt t0, t0, t1            # t0 = 0x00000001
addi s0, t0, 0            # s0 = 0x00000001
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
slt t1, t0, t1            # t1 = 0x00000001
addi s0, t1, 0            # s0 = 0x00000001

# Both read ports select the same source register.
addi t0, x0, -3           # t0 = 0xfffffffd
slt t2, t0, t0            # t2 = 0x00000000
