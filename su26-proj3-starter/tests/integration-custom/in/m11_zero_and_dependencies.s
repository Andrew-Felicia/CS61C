# Task 8: x0 loads/stores, load-use dependencies, and store using a freshly loaded register.
# EXPECT comments describe state AFTER each instruction.
# No LUI, pseudoinstructions, data directives, or uninitialized memory reads.

addi t0, x0, 1024          # EXPECT: t0 = 0x00000400
addi t1, x0, 515           # EXPECT: t1 = 0x00000203
slli t1, t1, 11            # EXPECT: t1 = 0x00101800
addi t1, t1, 2031          # EXPECT: t1 = 0x00101fef
slli t1, t1, 11            # EXPECT: t1 = 0x80ff7800
addi t1, t1, 1793          # EXPECT: t1 = 0x80ff7f01
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x80ff7f01; registers unchanged
addi t1, x0, 0             # EXPECT: t1 = 0x00000000
sw t1, 4(t0)               # EXPECT: mem[0x0404..0x0407] = 0x00000000; registers unchanged
lb x0, 0(t0)               # EXPECT: x0 = 0x00000000 from mem[0x0400]
addi t2, x0, 0             # EXPECT: t2 = 0x00000000
lw s0, 0(t0)               # EXPECT: s0 = 0x80ff7f01 from mem[0x0400]
lh x0, 0(t0)               # EXPECT: x0 = 0x00000000 from mem[0x0400]
addi t2, x0, 0             # EXPECT: t2 = 0x00000000
lw s0, 0(t0)               # EXPECT: s0 = 0x80ff7f01 from mem[0x0400]
lw x0, 0(t0)               # EXPECT: x0 = 0x00000000 from mem[0x0400]
addi t2, x0, 0             # EXPECT: t2 = 0x00000000
lw s0, 0(t0)               # EXPECT: s0 = 0x80ff7f01 from mem[0x0400]
addi t1, x0, -1            # EXPECT: t1 = 0xffffffff
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0xffffffff; registers unchanged
sb x0, 1(t0)               # EXPECT: mem[0x0401..0x0401] = 0x00; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0xffff00ff from mem[0x0400]
addi t1, x0, -1            # EXPECT: t1 = 0xffffffff
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0xffffffff; registers unchanged
sh x0, 2(t0)               # EXPECT: mem[0x0402..0x0403] = 0x0000; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x0000ffff from mem[0x0400]
addi t1, x0, -1            # EXPECT: t1 = 0xffffffff
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0xffffffff; registers unchanged
sw x0, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x00000000; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x00000000 from mem[0x0400]
addi t1, x0, 512           # EXPECT: t1 = 0x00000200
slli t1, t1, 11            # EXPECT: t1 = 0x00100000
slli t1, t1, 11            # EXPECT: t1 = 0x80000000
addi t1, t1, 1             # EXPECT: t1 = 0x80000001
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x80000001; registers unchanged
lw t1, 0(t0)               # EXPECT: t1 = 0x80000001 from mem[0x0400]
addi t2, t1, 1             # EXPECT: t2 = 0x80000002
sw t2, 4(t0)               # EXPECT: mem[0x0404..0x0407] = 0x80000002; registers unchanged
lw s0, 4(t0)               # EXPECT: s0 = 0x80000002 from mem[0x0404]
lb t1, 3(t0)               # EXPECT: t1 = 0xffffff80 from mem[0x0403]
add s1, t1, t1             # EXPECT: s1 = 0xffffff00
sb s1, 4(t0)               # EXPECT: mem[0x0404..0x0404] = 0x00; registers unchanged
lw a0, 4(t0)               # EXPECT: a0 = 0x80000000 from mem[0x0404]
