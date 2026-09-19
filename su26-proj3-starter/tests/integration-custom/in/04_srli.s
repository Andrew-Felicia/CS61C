# SRLI: negative operands must be zero-filled, including shifts by 0 and 31.
# Comments give the destination value AFTER each instruction (RV32).
# Straight-line test: the integration harness performs the comparison.

addi t0, x0, -1           # t0 = 0xffffffff
srli t1, t0, 0            # t1 = 0xffffffff
srli t2, t0, 1            # t2 = 0x7fffffff
srli s0, t0, 4            # s0 = 0x0fffffff
srli s1, t0, 16           # s1 = 0x0000ffff
srli a0, t0, 30           # a0 = 0x00000003
srli a1, t0, 31           # a1 = 0x00000001
addi t0, x0, -2048        # t0 = 0xfffff800
srli t1, t0, 1            # t1 = 0x7ffffc00
srli t2, t0, 11           # t2 = 0x001fffff
srli s0, t0, 31           # s0 = 0x00000001
addi t0, x0, 2047         # t0 = 0x000007ff
srli s1, t0, 1            # s1 = 0x000003ff
srli a0, t0, 10           # a0 = 0x00000001
srli a1, t0, 11           # a1 = 0x00000000
srli a2, x0, 31           # a2 = 0x00000000
addi t0, x0, -1           # t0 = 0xffffffff
srli t0, t0, 16           # t0 = 0x0000ffff
srli t0, t0, 16           # t0 = 0x00000000
