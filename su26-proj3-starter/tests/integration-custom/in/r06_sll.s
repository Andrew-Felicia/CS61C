# Task 6: SLL operand and boundary cases.
# Expected destination values after each instruction, in RV32 hexadecimal.
# Uses only Task 5 setup instructions and the Task 6 instructions named here.
# The course integration harness supplies pass/fail comparisons.

# Case 1: rs1 = 0x80000001, rs2 = 0x00000000.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t0, t0, 1            # t0 = 0x80000001
addi t1, x0, 0            # t1 = 0x00000000
sll t2, t0, t1            # t2 = 0x80000001

# Case 2: rs1 = 0x80000001, rs2 = 0x00000001.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t0, t0, 1            # t0 = 0x80000001
addi t1, x0, 1            # t1 = 0x00000001
sll t2, t0, t1            # t2 = 0x00000002

# Case 3: rs1 = 0x80000001, rs2 = 0x00000004.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t0, t0, 1            # t0 = 0x80000001
addi t1, x0, 4            # t1 = 0x00000004
sll t2, t0, t1            # t2 = 0x00000010

# Case 4: rs1 = 0x80000001, rs2 = 0x00000010.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t0, t0, 1            # t0 = 0x80000001
addi t1, x0, 16           # t1 = 0x00000010
sll t2, t0, t1            # t2 = 0x00010000

# Case 5: rs1 = 0x80000001, rs2 = 0x0000001f.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t0, t0, 1            # t0 = 0x80000001
addi t1, x0, 31           # t1 = 0x0000001f
sll t2, t0, t1            # t2 = 0x80000000

# Case 6: rs1 = 0x80000001, rs2 = 0x00000020.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t0, t0, 1            # t0 = 0x80000001
addi t1, x0, 32           # t1 = 0x00000020
sll t2, t0, t1            # t2 = 0x80000001

# Case 7: rs1 = 0x80000001, rs2 = 0x00000021.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t0, t0, 1            # t0 = 0x80000001
addi t1, x0, 33           # t1 = 0x00000021
sll t2, t0, t1            # t2 = 0x00000002

# Case 8: rs1 = 0x80000001, rs2 = 0x0000003f.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t0, t0, 1            # t0 = 0x80000001
addi t1, x0, 63           # t1 = 0x0000003f
sll t2, t0, t1            # t2 = 0x80000000

# Case 9: rs1 = 0x80000001, rs2 = 0x00000040.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t0, t0, 1            # t0 = 0x80000001
addi t1, x0, 64           # t1 = 0x00000040
sll t2, t0, t1            # t2 = 0x80000001

# Case 10: rs1 = 0x80000001, rs2 = 0xffffffff.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t0, t0, 1            # t0 = 0x80000001
addi t1, x0, -1           # t1 = 0xffffffff
sll t2, t0, t1            # t2 = 0x80000000

# Case 11: rs1 = 0x80000001, rs2 = 0x80000020.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t0, t0, 1            # t0 = 0x80000001
addi t1, x0, 512          # t1 = 0x00000200
slli t1, t1, 11           # t1 = 0x00100000
slli t1, t1, 11           # t1 = 0x80000000
addi t1, t1, 32           # t1 = 0x80000020
sll t2, t0, t1            # t2 = 0x80000001

# Case 12: rs1 = 0x00000000, rs2 = 0x0000001f.
addi t0, x0, 0            # t0 = 0x00000000
addi t1, x0, 31           # t1 = 0x0000001f
sll t2, t0, t1            # t2 = 0x00000000

# Case 13: rs1 = 0x7fffffff, rs2 = 0x00000001.
addi t0, x0, 511          # t0 = 0x000001ff
slli t0, t0, 11           # t0 = 0x000ff800
addi t0, t0, 2047         # t0 = 0x000fffff
slli t0, t0, 11           # t0 = 0x7ffff800
addi t0, t0, 2047         # t0 = 0x7fffffff
addi t1, x0, 1            # t1 = 0x00000001
sll t2, t0, t1            # t2 = 0xfffffffe

# Case 14: rs1 = 0xfffffffd, rs2 = 0x00000001.
addi t0, x0, -3           # t0 = 0xfffffffd
addi t1, x0, 1            # t1 = 0x00000001
sll t2, t0, t1            # t2 = 0xfffffffa

# Destination aliases rs1, then rs2; consume each result immediately.
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
sll t0, t0, t1            # t0 = 0xffffffc8
addi s0, t0, 0            # s0 = 0xffffffc8
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
sll t1, t0, t1            # t1 = 0xffffffc8
addi s0, t1, 0            # s0 = 0xffffffc8

# Both read ports select the same source register.
addi t0, x0, -3           # t0 = 0xfffffffd
sll t2, t0, t0            # t2 = 0xa0000000
