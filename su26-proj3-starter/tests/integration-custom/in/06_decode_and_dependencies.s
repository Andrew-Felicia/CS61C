# Alternate ALU selections; high immediate bits are data except for shift encoding.
# Comments give the destination value AFTER each instruction (RV32).
# Straight-line test: the integration harness performs the comparison.

addi t0, x0, -16          # t0 = 0xfffffff0
srli t1, t0, 4            # t1 = 0x0fffffff
srai t2, t0, 4            # t2 = 0xffffffff
srli s0, t0, 1            # s0 = 0x7ffffff8
srai s1, t0, 1            # s1 = 0xfffffff8
addi t0, x0, 85           # t0 = 0x00000055
addi t1, t0, 1024         # t1 = 0x00000455
andi t2, t0, 1024         # t2 = 0x00000000
ori s0, t0, 1024          # s0 = 0x00000455
xori s1, t0, 1024         # s1 = 0x00000455
addi a0, t0, -1024        # a0 = 0xfffffc55
andi a1, t0, -1024        # a1 = 0x00000000
ori a2, t0, -1024         # a2 = 0xfffffc55
xori a3, t0, -1024        # a3 = 0xfffffc55
addi t0, x0, 5            # t0 = 0x00000005
slli t0, t0, 3            # t0 = 0x00000028
ori t0, t0, 3             # t0 = 0x0000002b
xori t0, t0, -1           # t0 = 0xffffffd4
srai t0, t0, 2            # t0 = 0xfffffff5
andi t0, t0, 255          # t0 = 0x000000f5
srli t0, t0, 3            # t0 = 0x0000001e
addi t0, t0, -31          # t0 = 0xffffffff
addi t1, t0, 0            # t1 = 0xffffffff
