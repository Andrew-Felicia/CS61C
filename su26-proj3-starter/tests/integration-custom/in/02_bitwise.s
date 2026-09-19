# ANDI/ORI/XORI: masks, negative immediates, and distinct ALU operations.
# Comments give the destination value AFTER each instruction (RV32).
# Straight-line test: the integration harness performs the comparison.

addi t0, x0, 1365         # t0 = 0x00000555
andi t1, t0, 819          # t1 = 0x00000111
ori t2, t0, 819           # t2 = 0x00000777
xori s0, t0, 819          # s0 = 0x00000666
andi s1, t0, 0            # s1 = 0x00000000
ori a0, t0, 0             # a0 = 0x00000555
xori a1, t0, 0            # a1 = 0x00000555
andi t1, t0, -1           # t1 = 0x00000555
ori t2, t0, -1            # t2 = 0xffffffff
xori s0, t0, -1           # s0 = 0xfffffaaa
andi s1, t0, -2048        # s1 = 0x00000000
ori a0, t0, -2048         # a0 = 0xfffffd55
xori a1, t0, -2048        # a1 = 0xfffffd55
addi t0, x0, -1           # t0 = 0xffffffff
andi t1, t0, 2047         # t1 = 0x000007ff
ori t2, x0, -2048         # t2 = 0xfffff800
xori s0, t0, -2048        # s0 = 0x000007ff
andi s1, t0, -2048        # s1 = 0xfffff800
ori a0, x0, 2047          # a0 = 0x000007ff
xori a1, x0, -1           # a1 = 0xffffffff
addi t0, x0, 1365         # t0 = 0x00000555
xori t0, t0, 819          # t0 = 0x00000666
andi t0, t0, 255          # t0 = 0x00000066
ori t0, t0, 1024          # t0 = 0x00000466
