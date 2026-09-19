# Task 6: AND operand and boundary cases.
# Expected destination values after each instruction, in RV32 hexadecimal.
# Uses only Task 5 setup instructions and the Task 6 instructions named here.
# The course integration harness supplies pass/fail comparisons.

# Case 1: rs1 = 0x00000000, rs2 = 0x00000000.
addi t0, x0, 0            # t0 = 0x00000000
addi t1, x0, 0            # t1 = 0x00000000
and t2, t0, t1            # t2 = 0x00000000

# Case 2: rs1 = 0x00000000, rs2 = 0xffffffff.
addi t0, x0, 0            # t0 = 0x00000000
addi t1, x0, -1           # t1 = 0xffffffff
and t2, t0, t1            # t2 = 0x00000000

# Case 3: rs1 = 0xffffffff, rs2 = 0x00000000.
addi t0, x0, -1           # t0 = 0xffffffff
addi t1, x0, 0            # t1 = 0x00000000
and t2, t0, t1            # t2 = 0x00000000

# Case 4: rs1 = 0xffffffff, rs2 = 0xffffffff.
addi t0, x0, -1           # t0 = 0xffffffff
addi t1, x0, -1           # t1 = 0xffffffff
and t2, t0, t1            # t2 = 0xffffffff

# Case 5: rs1 = 0xaaaaaaaa, rs2 = 0x55555555.
addi t0, x0, 682          # t0 = 0x000002aa
slli t0, t0, 11           # t0 = 0x00155000
addi t0, t0, 1365         # t0 = 0x00155555
slli t0, t0, 11           # t0 = 0xaaaaa800
addi t0, t0, 682          # t0 = 0xaaaaaaaa
addi t1, x0, 341          # t1 = 0x00000155
slli t1, t1, 11           # t1 = 0x000aa800
addi t1, t1, 682          # t1 = 0x000aaaaa
slli t1, t1, 11           # t1 = 0x55555000
addi t1, t1, 1365         # t1 = 0x55555555
and t2, t0, t1            # t2 = 0x00000000

# Case 6: rs1 = 0x12345678, rs2 = 0x0f0f0f0f.
addi t0, x0, 72           # t0 = 0x00000048
slli t0, t0, 11           # t0 = 0x00024000
addi t0, t0, 1674         # t0 = 0x0002468a
slli t0, t0, 11           # t0 = 0x12345000
addi t0, t0, 1656         # t0 = 0x12345678
addi t1, x0, 60           # t1 = 0x0000003c
slli t1, t1, 11           # t1 = 0x0001e000
addi t1, t1, 481          # t1 = 0x0001e1e1
slli t1, t1, 11           # t1 = 0x0f0f0800
addi t1, t1, 1807         # t1 = 0x0f0f0f0f
and t2, t0, t1            # t2 = 0x02040608

# Case 7: rs1 = 0x80000000, rs2 = 0x7fffffff.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t1, x0, 511          # t1 = 0x000001ff
slli t1, t1, 11           # t1 = 0x000ff800
addi t1, t1, 2047         # t1 = 0x000fffff
slli t1, t1, 11           # t1 = 0x7ffff800
addi t1, t1, 2047         # t1 = 0x7fffffff
and t2, t0, t1            # t2 = 0x00000000

# Case 8: rs1 = 0x80000001, rs2 = 0x80000000.
addi t0, x0, 512          # t0 = 0x00000200
slli t0, t0, 11           # t0 = 0x00100000
slli t0, t0, 11           # t0 = 0x80000000
addi t0, t0, 1            # t0 = 0x80000001
addi t1, x0, 512          # t1 = 0x00000200
slli t1, t1, 11           # t1 = 0x00100000
slli t1, t1, 11           # t1 = 0x80000000
and t2, t0, t1            # t2 = 0x80000000

# Destination aliases rs1, then rs2; consume each result immediately.
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
and t0, t0, t1            # t0 = 0x00000001
addi s0, t0, 0            # s0 = 0x00000001
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
and t1, t0, t1            # t1 = 0x00000001
addi s0, t1, 0            # s0 = 0x00000001

# Both read ports select the same source register.
addi t0, x0, -3           # t0 = 0xfffffffd
and t2, t0, t0            # t2 = 0xfffffffd
