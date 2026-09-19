# Task 8: Stores must not write the register selected by instruction bits [11:7].
# EXPECT comments describe state AFTER each instruction.
# No LUI, pseudoinstructions, data directives, or uninitialized memory reads.

addi x20, x0, 1024         # EXPECT: x20 = 0x00000400
addi x21, x0, 72           # EXPECT: x21 = 0x00000048
slli x21, x21, 11          # EXPECT: x21 = 0x00024000
addi x21, x21, 1680        # EXPECT: x21 = 0x00024690
slli x21, x21, 11          # EXPECT: x21 = 0x12348000
addi x21, x21, 255         # EXPECT: x21 = 0x123480ff

# sb offset 1: bits [11:7] alias x1, which must keep its sentinel.
sw x0, 0(x20)              # EXPECT: mem[0x0400..0x0403] = 0x00000000; registers unchanged
addi x1, x0, 778           # EXPECT: x1 = 0x0000030a
sb x21, 1(x20)             # EXPECT: mem[0x0401..0x0401] = 0xff; registers unchanged
addi t2, x1, 0             # EXPECT: t2 = 0x0000030a
lw a0, 0(x20)              # EXPECT: a0 = 0x0000ff00 from mem[0x0400]

# sb offset 5: bits [11:7] alias x5, which must keep its sentinel.
sw x0, 4(x20)              # EXPECT: mem[0x0404..0x0407] = 0x00000000; registers unchanged
addi x5, x0, 782           # EXPECT: x5 = 0x0000030e
sb x21, 5(x20)             # EXPECT: mem[0x0405..0x0405] = 0xff; registers unchanged
addi t2, x5, 0             # EXPECT: t2 = 0x0000030e
lw a0, 4(x20)              # EXPECT: a0 = 0x0000ff00 from mem[0x0404]

# sb offset 7: bits [11:7] alias x7, which must keep its sentinel.
sw x0, 4(x20)              # EXPECT: mem[0x0404..0x0407] = 0x00000000; registers unchanged
addi x7, x0, 784           # EXPECT: x7 = 0x00000310
sb x21, 7(x20)             # EXPECT: mem[0x0407..0x0407] = 0xff; registers unchanged
addi t2, x7, 0             # EXPECT: t2 = 0x00000310
lw a0, 4(x20)              # EXPECT: a0 = 0xff000000 from mem[0x0404]

# sb offset 8: bits [11:7] alias x8, which must keep its sentinel.
sw x0, 8(x20)              # EXPECT: mem[0x0408..0x040b] = 0x00000000; registers unchanged
addi x8, x0, 785           # EXPECT: x8 = 0x00000311
sb x21, 8(x20)             # EXPECT: mem[0x0408..0x0408] = 0xff; registers unchanged
addi t2, x8, 0             # EXPECT: t2 = 0x00000311
lw a0, 8(x20)              # EXPECT: a0 = 0x000000ff from mem[0x0408]

# sb offset 12: bits [11:7] alias x12, which must keep its sentinel.
sw x0, 12(x20)             # EXPECT: mem[0x040c..0x040f] = 0x00000000; registers unchanged
addi x12, x0, 789          # EXPECT: x12 = 0x00000315
sb x21, 12(x20)            # EXPECT: mem[0x040c..0x040c] = 0xff; registers unchanged
addi t2, x12, 0            # EXPECT: t2 = 0x00000315
lw a0, 12(x20)             # EXPECT: a0 = 0x000000ff from mem[0x040c]

# sb offset 31: bits [11:7] alias x31, which must keep its sentinel.
sw x0, 28(x20)             # EXPECT: mem[0x041c..0x041f] = 0x00000000; registers unchanged
addi x31, x0, 808          # EXPECT: x31 = 0x00000328
sb x21, 31(x20)            # EXPECT: mem[0x041f..0x041f] = 0xff; registers unchanged
addi t2, x31, 0            # EXPECT: t2 = 0x00000328
lw a0, 28(x20)             # EXPECT: a0 = 0xff000000 from mem[0x041c]

# sh offset 2: bits [11:7] alias x2, which must keep its sentinel.
sw x0, 0(x20)              # EXPECT: mem[0x0400..0x0403] = 0x00000000; registers unchanged
addi x2, x0, 779           # EXPECT: x2 = 0x0000030b
sh x21, 2(x20)             # EXPECT: mem[0x0402..0x0403] = 0x80ff; registers unchanged
addi t2, x2, 0             # EXPECT: t2 = 0x0000030b
lw a0, 0(x20)              # EXPECT: a0 = 0x80ff0000 from mem[0x0400]

# sh offset 6: bits [11:7] alias x6, which must keep its sentinel.
sw x0, 4(x20)              # EXPECT: mem[0x0404..0x0407] = 0x00000000; registers unchanged
addi x6, x0, 783           # EXPECT: x6 = 0x0000030f
sh x21, 6(x20)             # EXPECT: mem[0x0406..0x0407] = 0x80ff; registers unchanged
addi t2, x6, 0             # EXPECT: t2 = 0x0000030f
lw a0, 4(x20)              # EXPECT: a0 = 0x80ff0000 from mem[0x0404]

# sh offset 8: bits [11:7] alias x8, which must keep its sentinel.
sw x0, 8(x20)              # EXPECT: mem[0x0408..0x040b] = 0x00000000; registers unchanged
addi x8, x0, 785           # EXPECT: x8 = 0x00000311
sh x21, 8(x20)             # EXPECT: mem[0x0408..0x0409] = 0x80ff; registers unchanged
addi t2, x8, 0             # EXPECT: t2 = 0x00000311
lw a0, 8(x20)              # EXPECT: a0 = 0x000080ff from mem[0x0408]

# sh offset 12: bits [11:7] alias x12, which must keep its sentinel.
sw x0, 12(x20)             # EXPECT: mem[0x040c..0x040f] = 0x00000000; registers unchanged
addi x12, x0, 789          # EXPECT: x12 = 0x00000315
sh x21, 12(x20)            # EXPECT: mem[0x040c..0x040d] = 0x80ff; registers unchanged
addi t2, x12, 0            # EXPECT: t2 = 0x00000315
lw a0, 12(x20)             # EXPECT: a0 = 0x000080ff from mem[0x040c]

# sh offset 30: bits [11:7] alias x30, which must keep its sentinel.
sw x0, 28(x20)             # EXPECT: mem[0x041c..0x041f] = 0x00000000; registers unchanged
addi x30, x0, 807          # EXPECT: x30 = 0x00000327
sh x21, 30(x20)            # EXPECT: mem[0x041e..0x041f] = 0x80ff; registers unchanged
addi t2, x30, 0            # EXPECT: t2 = 0x00000327
lw a0, 28(x20)             # EXPECT: a0 = 0x80ff0000 from mem[0x041c]

# sw offset 4: bits [11:7] alias x4, which must keep its sentinel.
sw x0, 4(x20)              # EXPECT: mem[0x0404..0x0407] = 0x00000000; registers unchanged
addi x4, x0, 781           # EXPECT: x4 = 0x0000030d
sw x21, 4(x20)             # EXPECT: mem[0x0404..0x0407] = 0x123480ff; registers unchanged
addi t2, x4, 0             # EXPECT: t2 = 0x0000030d
lw a0, 4(x20)              # EXPECT: a0 = 0x123480ff from mem[0x0404]

# sw offset 8: bits [11:7] alias x8, which must keep its sentinel.
sw x0, 8(x20)              # EXPECT: mem[0x0408..0x040b] = 0x00000000; registers unchanged
addi x8, x0, 785           # EXPECT: x8 = 0x00000311
sw x21, 8(x20)             # EXPECT: mem[0x0408..0x040b] = 0x123480ff; registers unchanged
addi t2, x8, 0             # EXPECT: t2 = 0x00000311
lw a0, 8(x20)              # EXPECT: a0 = 0x123480ff from mem[0x0408]

# sw offset 12: bits [11:7] alias x12, which must keep its sentinel.
sw x0, 12(x20)             # EXPECT: mem[0x040c..0x040f] = 0x00000000; registers unchanged
addi x12, x0, 789          # EXPECT: x12 = 0x00000315
sw x21, 12(x20)            # EXPECT: mem[0x040c..0x040f] = 0x123480ff; registers unchanged
addi t2, x12, 0            # EXPECT: t2 = 0x00000315
lw a0, 12(x20)             # EXPECT: a0 = 0x123480ff from mem[0x040c]

# sw offset 28: bits [11:7] alias x28, which must keep its sentinel.
sw x0, 28(x20)             # EXPECT: mem[0x041c..0x041f] = 0x00000000; registers unchanged
addi x28, x0, 805          # EXPECT: x28 = 0x00000325
sw x21, 28(x20)            # EXPECT: mem[0x041c..0x041f] = 0x123480ff; registers unchanged
addi t2, x28, 0            # EXPECT: t2 = 0x00000325
lw a0, 28(x20)             # EXPECT: a0 = 0x123480ff from mem[0x041c]
addi s0, x20, 0            # EXPECT: s0 = 0x00000400
addi s1, x21, 0            # EXPECT: s1 = 0x123480ff
