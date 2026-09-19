# ADDI: signed immediate boundaries, carry, wraparound, and rd == rs1.
# Comments give the destination value AFTER each instruction (RV32).
# Straight-line test: the integration harness performs the comparison.

addi t0, x0, 0            # t0 = 0x00000000
addi t1, x0, 2047         # t1 = 0x000007ff
addi t2, x0, -2048        # t2 = 0xfffff800
addi s0, x0, -1           # s0 = 0xffffffff
addi s1, t1, 1            # s1 = 0x00000800
addi a0, t2, -1           # a0 = 0xfffff7ff
addi a1, s0, 1            # a1 = 0x00000000
addi a2, t1, -2048        # a2 = 0xffffffff
addi t0, x0, 1            # t0 = 0x00000001
addi t0, t0, -2           # t0 = 0xffffffff
addi t0, t0, 1            # t0 = 0x00000000
addi t0, t0, 1024         # t0 = 0x00000400
addi t0, t0, -1024        # t0 = 0x00000000
addi t1, x0, 37           # t1 = 0x00000025
addi t2, t1, -17          # t2 = 0x00000014
addi s0, t1, 0            # s0 = 0x00000025
addi s1, t2, 2047         # s1 = 0x00000813
addi a0, s1, -2048        # a0 = 0x00000013
