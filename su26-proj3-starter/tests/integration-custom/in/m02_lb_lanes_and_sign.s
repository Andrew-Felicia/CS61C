# Task 8: LB at all four byte positions; sign comes from the selected byte.
# EXPECT comments describe state AFTER each instruction.
# No LUI, pseudoinstructions, data directives, or uninitialized memory reads.

addi t0, x0, 1024          # EXPECT: t0 = 0x00000400

# Backing word 0x80ff7f00.
addi t1, x0, 515           # EXPECT: t1 = 0x00000203
slli t1, t1, 11            # EXPECT: t1 = 0x00101800
addi t1, t1, 2031          # EXPECT: t1 = 0x00101fef
slli t1, t1, 11            # EXPECT: t1 = 0x80ff7800
addi t1, t1, 1792          # EXPECT: t1 = 0x80ff7f00
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x80ff7f00; registers unchanged
lb a0, 0(t0)               # EXPECT: a0 = 0x00000000 from mem[0x0400]
lb a1, 1(t0)               # EXPECT: a1 = 0x0000007f from mem[0x0401]
lb a2, 2(t0)               # EXPECT: a2 = 0xffffffff from mem[0x0402]
lb a3, 3(t0)               # EXPECT: a3 = 0xffffff80 from mem[0x0403]
lw t2, 0(t0)               # EXPECT: t2 = 0x80ff7f00 from mem[0x0400]

# Backing word 0x7f0080ff.
addi t1, x0, 508           # EXPECT: t1 = 0x000001fc
slli t1, t1, 11            # EXPECT: t1 = 0x000fe000
addi t1, t1, 16            # EXPECT: t1 = 0x000fe010
slli t1, t1, 11            # EXPECT: t1 = 0x7f008000
addi t1, t1, 255           # EXPECT: t1 = 0x7f0080ff
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x7f0080ff; registers unchanged
lb a0, 0(t0)               # EXPECT: a0 = 0xffffffff from mem[0x0400]
lb a1, 1(t0)               # EXPECT: a1 = 0xffffff80 from mem[0x0401]
lb a2, 2(t0)               # EXPECT: a2 = 0x00000000 from mem[0x0402]
lb a3, 3(t0)               # EXPECT: a3 = 0x0000007f from mem[0x0403]
lw t2, 0(t0)               # EXPECT: t2 = 0x7f0080ff from mem[0x0400]

# Backing word 0x01020304.
addi t1, x0, 4             # EXPECT: t1 = 0x00000004
slli t1, t1, 11            # EXPECT: t1 = 0x00002000
addi t1, t1, 64            # EXPECT: t1 = 0x00002040
slli t1, t1, 11            # EXPECT: t1 = 0x01020000
addi t1, t1, 772           # EXPECT: t1 = 0x01020304
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x01020304; registers unchanged
lb a0, 0(t0)               # EXPECT: a0 = 0x00000004 from mem[0x0400]
lb a1, 1(t0)               # EXPECT: a1 = 0x00000003 from mem[0x0401]
lb a2, 2(t0)               # EXPECT: a2 = 0x00000002 from mem[0x0402]
lb a3, 3(t0)               # EXPECT: a3 = 0x00000001 from mem[0x0403]
lw t2, 0(t0)               # EXPECT: t2 = 0x01020304 from mem[0x0400]
