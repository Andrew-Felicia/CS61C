# Writes to x0 must be ignored; exercise high register indices and read them back.
# Comments give the destination value AFTER each instruction (RV32).
# Straight-line test: the integration harness performs the comparison.

addi t0, x0, -1           # t0 = 0xffffffff
addi x0, t0, 17           # x0 = 0x00000000 (write ignored)
addi t1, x0, 0            # t1 = 0x00000000
andi x0, t0, 2047         # x0 = 0x00000000 (write ignored)
addi t1, x0, 0            # t1 = 0x00000000
ori x0, t0, 0             # x0 = 0x00000000 (write ignored)
addi t1, x0, 0            # t1 = 0x00000000
xori x0, x0, -1           # x0 = 0x00000000 (write ignored)
addi t1, x0, 0            # t1 = 0x00000000
slli x0, t0, 1            # x0 = 0x00000000 (write ignored)
addi t1, x0, 0            # t1 = 0x00000000
srli x0, t0, 1            # x0 = 0x00000000 (write ignored)
addi t1, x0, 0            # t1 = 0x00000000
srai x0, t0, 1            # x0 = 0x00000000 (write ignored)
addi t1, x0, 0            # t1 = 0x00000000
addi x31, x0, 123         # x31 = 0x0000007b
xori x16, x31, 85         # x16 = 0x0000002e
addi t2, x16, 0           # t2 = 0x0000002e
ori x17, x16, 256         # x17 = 0x0000012e
addi s0, x17, 0           # s0 = 0x0000012e
andi x30, x17, 255        # x30 = 0x0000002e
addi s1, x30, 0           # s1 = 0x0000002e
slli x31, x30, 3          # x31 = 0x00000170
addi a0, x31, 0           # a0 = 0x00000170
addi t2, x16, 0           # t2 = 0x0000002e
