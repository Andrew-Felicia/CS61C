# SRAI: sign-fill, negative odd values, positive values, and maximum shift.
# Comments give the destination value AFTER each instruction (RV32).
# Straight-line test: the integration harness performs the comparison.

addi t0, x0, -1           # t0 = 0xffffffff
srai t1, t0, 0            # t1 = 0xffffffff
srai t2, t0, 1            # t2 = 0xffffffff
srai s0, t0, 16           # s0 = 0xffffffff
srai s1, t0, 31           # s1 = 0xffffffff
addi t0, x0, -2048        # t0 = 0xfffff800
srai t1, t0, 1            # t1 = 0xfffffc00
srai t2, t0, 10           # t2 = 0xfffffffe
srai s0, t0, 11           # s0 = 0xffffffff
srai s1, t0, 31           # s1 = 0xffffffff
addi t0, x0, -3           # t0 = 0xfffffffd
srai a0, t0, 1            # a0 = 0xfffffffe
addi t0, x0, 2047         # t0 = 0x000007ff
srai a1, t0, 1            # a1 = 0x000003ff
srai a2, t0, 31           # a2 = 0x00000000
srai a3, x0, 31           # a3 = 0x00000000
addi t0, x0, -1025        # t0 = 0xfffffbff
srai t0, t0, 1            # t0 = 0xfffffdff
srai t0, t0, 10           # t0 = 0xffffffff
