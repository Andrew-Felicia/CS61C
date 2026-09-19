# Task 8: rd == base, high register indices, and one register as store base and data.
# EXPECT comments describe state AFTER each instruction.
# No LUI, pseudoinstructions, data directives, or uninitialized memory reads.

addi t0, x0, 1024          # EXPECT: t0 = 0x00000400
addi t1, x0, 72            # EXPECT: t1 = 0x00000048
slli t1, t1, 11            # EXPECT: t1 = 0x00024000
addi t1, t1, 1674          # EXPECT: t1 = 0x0002468a
slli t1, t1, 11            # EXPECT: t1 = 0x12345000
addi t1, t1, 1656          # EXPECT: t1 = 0x12345678
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x12345678; registers unchanged
addi t1, x0, 515           # EXPECT: t1 = 0x00000203
slli t1, t1, 11            # EXPECT: t1 = 0x00101800
addi t1, t1, 2031          # EXPECT: t1 = 0x00101fef
slli t1, t1, 11            # EXPECT: t1 = 0x80ff7800
addi t1, t1, 1792          # EXPECT: t1 = 0x80ff7f00
sw t1, 4(t0)               # EXPECT: mem[0x0404..0x0407] = 0x80ff7f00; registers unchanged
addi x31, x0, 1024         # EXPECT: x31 = 0x00000400
lw x31, 0(x31)             # EXPECT: x31 = 0x12345678 from mem[0x0400]
addi t2, x31, 0            # EXPECT: t2 = 0x12345678
addi x31, x0, 1024         # EXPECT: x31 = 0x00000400
lh x31, 6(x31)             # EXPECT: x31 = 0xffff80ff from mem[0x0406]
addi t2, x31, 0            # EXPECT: t2 = 0xffff80ff
addi x31, x0, 1024         # EXPECT: x31 = 0x00000400
lb x31, 7(x31)             # EXPECT: x31 = 0xffffff80 from mem[0x0407]
addi t2, x31, 0            # EXPECT: t2 = 0xffffff80
addi x16, x0, 1024         # EXPECT: x16 = 0x00000400
addi x17, x0, 890          # EXPECT: x17 = 0x0000037a
slli x17, x17, 11          # EXPECT: x17 = 0x001bd000
addi x17, x17, 1463        # EXPECT: x17 = 0x001bd5b7
slli x17, x17, 11          # EXPECT: x17 = 0xdeadb800
addi x17, x17, 1775        # EXPECT: x17 = 0xdeadbeef
sw x17, 0(x16)             # EXPECT: mem[0x0400..0x0403] = 0xdeadbeef; registers unchanged
lw x30, 0(x16)             # EXPECT: x30 = 0xdeadbeef from mem[0x0400]
addi s0, x30, 0            # EXPECT: s0 = 0xdeadbeef
addi x31, x0, 1024         # EXPECT: x31 = 0x00000400
sw x31, 8(x31)             # EXPECT: mem[0x0408..0x040b] = 0x00000400; registers unchanged
lw s1, 8(t0)               # EXPECT: s1 = 0x00000400 from mem[0x0408]
addi t1, x0, 1028          # EXPECT: t1 = 0x00000404
sw t1, 12(t0)              # EXPECT: mem[0x040c..0x040f] = 0x00000404; registers unchanged
lw x16, 12(t0)             # EXPECT: x16 = 0x00000404 from mem[0x040c]
lw a0, 0(x16)              # EXPECT: a0 = 0x80ff7f00 from mem[0x0404]
