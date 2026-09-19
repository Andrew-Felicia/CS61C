# SLLI: shift amounts 0, 1, 4, 16, 30, 31; truncation to 32 bits.
# Comments give the destination value AFTER each instruction (RV32).
# Straight-line test: the integration harness performs the comparison.

addi t0, x0, 1            # t0 = 0x00000001
slli t1, t0, 0            # t1 = 0x00000001
slli t2, t0, 1            # t2 = 0x00000002
slli s0, t0, 16           # s0 = 0x00010000
slli s1, t0, 30           # s1 = 0x40000000
slli a0, t0, 31           # a0 = 0x80000000
slli a1, a0, 1            # a1 = 0x00000000
addi t0, x0, -1           # t0 = 0xffffffff
slli t1, t0, 0            # t1 = 0xffffffff
slli t2, t0, 1            # t2 = 0xfffffffe
slli s0, t0, 4            # s0 = 0xfffffff0
slli s1, t0, 31           # s1 = 0x80000000
slli a0, x0, 31           # a0 = 0x00000000
addi t0, x0, 3            # t0 = 0x00000003
slli t0, t0, 4            # t0 = 0x00000030
slli t0, t0, 16           # t0 = 0x00300000
slli t0, t0, 16           # t0 = 0x00000000
