# Task 8: LH at byte positions 0, 1, 2 as specified by the course partial-load table.
# EXPECT comments describe state AFTER each instruction.
# No LUI, pseudoinstructions, data directives, or uninitialized memory reads.

addi t0, x0, 1024          # EXPECT: t0 = 0x00000400

# Backing word 0x80007fff; position 1 stays within this word.
addi t1, x0, 512           # EXPECT: t1 = 0x00000200
slli t1, t1, 11            # EXPECT: t1 = 0x00100000
addi t1, t1, 15            # EXPECT: t1 = 0x0010000f
slli t1, t1, 11            # EXPECT: t1 = 0x80007800
addi t1, t1, 2047          # EXPECT: t1 = 0x80007fff
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x80007fff; registers unchanged
lh a0, 0(t0)               # EXPECT: a0 = 0x00007fff from mem[0x0400]
lh a1, 1(t0)               # EXPECT: a1 = 0x0000007f from mem[0x0401]
lh a2, 2(t0)               # EXPECT: a2 = 0xffff8000 from mem[0x0402]
lw t2, 0(t0)               # EXPECT: t2 = 0x80007fff from mem[0x0400]

# Backing word 0x7fff8000; position 1 stays within this word.
addi t1, x0, 511           # EXPECT: t1 = 0x000001ff
slli t1, t1, 11            # EXPECT: t1 = 0x000ff800
addi t1, t1, 2032          # EXPECT: t1 = 0x000ffff0
slli t1, t1, 11            # EXPECT: t1 = 0x7fff8000
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x7fff8000; registers unchanged
lh a0, 0(t0)               # EXPECT: a0 = 0xffff8000 from mem[0x0400]
lh a1, 1(t0)               # EXPECT: a1 = 0xffffff80 from mem[0x0401]
lh a2, 2(t0)               # EXPECT: a2 = 0x00007fff from mem[0x0402]
lw t2, 0(t0)               # EXPECT: t2 = 0x7fff8000 from mem[0x0400]

# Backing word 0xffff0000; position 1 stays within this word.
addi t1, x0, 1023          # EXPECT: t1 = 0x000003ff
slli t1, t1, 11            # EXPECT: t1 = 0x001ff800
addi t1, t1, 2016          # EXPECT: t1 = 0x001fffe0
slli t1, t1, 11            # EXPECT: t1 = 0xffff0000
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0xffff0000; registers unchanged
lh a0, 0(t0)               # EXPECT: a0 = 0x00000000 from mem[0x0400]
lh a1, 1(t0)               # EXPECT: a1 = 0xffffff00 from mem[0x0401]
lh a2, 2(t0)               # EXPECT: a2 = 0xffffffff from mem[0x0402]
lw t2, 0(t0)               # EXPECT: t2 = 0xffff0000 from mem[0x0400]

# Backing word 0x0000ffff; position 1 stays within this word.
addi t1, x0, 0             # EXPECT: t1 = 0x00000000
slli t1, t1, 11            # EXPECT: t1 = 0x00000000
addi t1, t1, 31            # EXPECT: t1 = 0x0000001f
slli t1, t1, 11            # EXPECT: t1 = 0x0000f800
addi t1, t1, 2047          # EXPECT: t1 = 0x0000ffff
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x0000ffff; registers unchanged
lh a0, 0(t0)               # EXPECT: a0 = 0xffffffff from mem[0x0400]
lh a1, 1(t0)               # EXPECT: a1 = 0x000000ff from mem[0x0401]
lh a2, 2(t0)               # EXPECT: a2 = 0x00000000 from mem[0x0402]
lw t2, 0(t0)               # EXPECT: t2 = 0x0000ffff from mem[0x0400]

# Backing word 0x12345678; position 1 stays within this word.
addi t1, x0, 72            # EXPECT: t1 = 0x00000048
slli t1, t1, 11            # EXPECT: t1 = 0x00024000
addi t1, t1, 1674          # EXPECT: t1 = 0x0002468a
slli t1, t1, 11            # EXPECT: t1 = 0x12345000
addi t1, t1, 1656          # EXPECT: t1 = 0x12345678
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x12345678; registers unchanged
lh a0, 0(t0)               # EXPECT: a0 = 0x00005678 from mem[0x0400]
lh a1, 1(t0)               # EXPECT: a1 = 0x00003456 from mem[0x0401]
lh a2, 2(t0)               # EXPECT: a2 = 0x00001234 from mem[0x0402]
lw t2, 0(t0)               # EXPECT: t2 = 0x12345678 from mem[0x0400]
