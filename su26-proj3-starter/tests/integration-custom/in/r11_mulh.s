# Task 6: MULH operand and boundary cases.
# Expected destination values after each instruction, in RV32 hexadecimal.
# Uses only Task 5 setup instructions and the Task 6 instructions named here.
# The course integration harness supplies pass/fail comparisons.

# Case 1: rs1 = 0x00000000, rs2 = 0x87654321.
addi t0, x0, 0            # t0 = 0x00000000
addi t1, x0, 541          # t1 = 0x0000021d
slli t1, t1, 11           # t1 = 0x0010e800
addi t1, t1, 1192         # t1 = 0x0010eca8
slli t1, t1, 11           # t1 = 0x87654000
addi t1, t1, 801          # t1 = 0x87654321
mulh t2, t0, t1           # t2 = 0x00000000

# Case 2: rs1 = 0x00000001, rs2 = 0x87654321.
addi t0, x0, 1            # t0 = 0x00000001
addi t1, x0, 541          # t1 = 0x0000021d
slli t1, t1, 11           # t1 = 0x0010e800
addi t1, t1, 1192         # t1 = 0x0010eca8
slli t1, t1, 11           # t1 = 0x87654000
addi t1, t1, 801          # t1 = 0x87654321
mulh t2, t0, t1           # t2 = 0xffffffff

# Case 3: rs1 = 0x00000007, rs2 = 0x00000009.
addi t0, x0, 7            # t0 = 0x00000007
addi t1, x0, 9            # t1 = 0x00000009
mulh t2, t0, t1           # t2 = 0x00000000

# Case 4: rs1 = 0xfffffff9, rs2 = 0x00000009.
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 9            # t1 = 0x00000009
mulh t2, t0, t1           # t2 = 0xffffffff

# Case 5: rs1 = 0x00000007, rs2 = 0xfffffff7.
addi t0, x0, 7            # t0 = 0x00000007
addi t1, x0, -9           # t1 = 0xfffffff7
mulh t2, t0, t1           # t2 = 0xffffffff

# Case 6: rs1 = 0xfffffff9, rs2 = 0xfffffff7.
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, -9           # t1 = 0xfffffff7
mulh t2, t0, t1           # t2 = 0x00000000

# Case 7: rs1 = 0xffffffff, rs2 = 0xffffffff.
addi t0, x0, -1           # t0 = 0xffffffff
addi t1, x0, -1           # t1 = 0xffffffff
mulh t2, t0, t1           # t2 = 0x00000000

# Case 8: rs1 = 0xffffffff, rs2 = 0x00000002.
addi t0, x0, -1           # t0 = 0xffffffff
addi t1, x0, 2            # t1 = 0x00000002
mulh t2, t0, t1           # t2 = 0xffffffff

# Case 9: rs1 = 0x00000002, rs2 = 0xffffffff.
addi t0, x0, 2            # t0 = 0x00000002
addi t1, x0, -1           # t1 = 0xffffffff
mulh t2, t0, t1           # t2 = 0xffffffff

# Case 10: rs1 = 0x00010000, rs2 = 0x00010000.
addi t0, x0, 0            # t0 = 0x00000000
slli t0, t0, 11           # t0 = 0x00000000
addi t0, t0, 32           # t0 = 0x00000020
slli t0, t0, 11           # t0 = 0x00010000
addi t1, x0, 0            # t1 = 0x00000000
slli t1, t1, 11           # t1 = 0x00000000
addi t1, t1, 32           # t1 = 0x00000020
slli t1, t1, 11           # t1 = 0x00010000
mulh t2, t0, t1           # t2 = 0x00000001

# Case 11: rs1 = 0x7fffffff, rs2 = 0x7fffffff.
addi t0, x0, 511          # t0 = 0x000001ff
slli t0, t0, 11           # t0 = 0x000ff800
addi t0, t0, 2047         # t0 = 0x000fffff
slli t0, t0, 11           # t0 = 0x7ffff800
addi t0, t0, 2047         # t0 = 0x7fffffff
addi t1, x0, 511          # t1 = 0x000001ff
slli t1, t1, 11           # t1 = 0x000ff800
addi t1, t1, 2047         # t1 = 0x000fffff
slli t1, t1, 11           # t1 = 0x7ffff800
addi t1, t1, 2047         # t1 = 0x7fffffff
mulh t2, t0, t1           # t2 = 0x3fffffff

# Case 12: rs1 = 0x80000000, rs2 = 0xffffffff.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t1, x0, -1           # t1 = 0xffffffff
mulh t2, t0, t1           # t2 = 0x00000000

# Case 13: rs1 = 0x80000000, rs2 = 0x00000002.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t1, x0, 2            # t1 = 0x00000002
mulh t2, t0, t1           # t2 = 0xffffffff

# Case 14: rs1 = 0x80000000, rs2 = 0x80000000.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t1, x0, 512          # t1 = 0x00000200
slli t1, t1, 11           # t1 = 0x00100000
slli t1, t1, 11           # t1 = 0x80000000
mulh t2, t0, t1           # t2 = 0x40000000

# Case 15: rs1 = 0x12345678, rs2 = 0x9abcdef0.
addi t0, x0, 72           # t0 = 0x00000048
slli t0, t0, 11           # t0 = 0x00024000
addi t0, t0, 1674         # t0 = 0x0002468a
slli t0, t0, 11           # t0 = 0x12345000
addi t0, t0, 1656         # t0 = 0x12345678
addi t1, x0, 618          # t1 = 0x0000026a
slli t1, t1, 11           # t1 = 0x00135000
addi t1, t1, 1947         # t1 = 0x0013579b
slli t1, t1, 11           # t1 = 0x9abcd800
addi t1, t1, 1776         # t1 = 0x9abcdef0
mulh t2, t0, t1           # t2 = 0xf8cc93d6

# Destination aliases rs1, then rs2; consume each result immediately.
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
mulh t0, t0, t1           # t0 = 0xffffffff
addi s0, t0, 0            # s0 = 0xffffffff
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
mulh t1, t0, t1           # t1 = 0xffffffff
addi s0, t1, 0            # s0 = 0xffffffff

# Both read ports select the same source register.
addi t0, x0, -3           # t0 = 0xfffffffd
mulh t2, t0, t0           # t2 = 0x00000000
