# Task 8: SH: lower/upper halfword, preserve other bytes and adjacent words.
# EXPECT comments describe state AFTER each instruction.
# No LUI, pseudoinstructions, data directives, or uninitialized memory reads.

addi t0, x0, 1024          # EXPECT: t0 = 0x00000400
addi t1, x0, 341           # EXPECT: t1 = 0x00000155
slli t1, t1, 11            # EXPECT: t1 = 0x000aa800
addi t1, t1, 1230          # EXPECT: t1 = 0x000aacce
slli t1, t1, 11            # EXPECT: t1 = 0x55667000
addi t1, t1, 1928          # EXPECT: t1 = 0x55667788
sw t1, -4(t0)              # EXPECT: mem[0x03fc..0x03ff] = 0x55667788; registers unchanged
addi t1, x0, 614           # EXPECT: t1 = 0x00000266
slli t1, t1, 11            # EXPECT: t1 = 0x00133000
addi t1, t1, 1367          # EXPECT: t1 = 0x00133557
slli t1, t1, 11            # EXPECT: t1 = 0x99aab800
addi t1, t1, 972           # EXPECT: t1 = 0x99aabbcc
sw t1, 4(t0)               # EXPECT: mem[0x0404..0x0407] = 0x99aabbcc; registers unchanged

# Lane 0; only low halfword 0x0000 may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1600          # EXPECT: t1 = 0x00143640
slli t1, t1, 11            # EXPECT: t1 = 0xa1b20000
sh t1, 0(t0)               # EXPECT: mem[0x0400..0x0401] = 0x0000; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x11220000 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lh a0, 0(t0)               # EXPECT: a0 = 0x00000000 from mem[0x0400]

# Lane 0; only low halfword 0x7fff may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1615          # EXPECT: t1 = 0x0014364f
slli t1, t1, 11            # EXPECT: t1 = 0xa1b27800
addi t1, t1, 2047          # EXPECT: t1 = 0xa1b27fff
sh t1, 0(t0)               # EXPECT: mem[0x0400..0x0401] = 0x7fff; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x11227fff from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lh a0, 0(t0)               # EXPECT: a0 = 0x00007fff from mem[0x0400]

# Lane 0; only low halfword 0x8000 may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1616          # EXPECT: t1 = 0x00143650
slli t1, t1, 11            # EXPECT: t1 = 0xa1b28000
sh t1, 0(t0)               # EXPECT: mem[0x0400..0x0401] = 0x8000; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x11228000 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lh a0, 0(t0)               # EXPECT: a0 = 0xffff8000 from mem[0x0400]

# Lane 0; only low halfword 0xffff may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1631          # EXPECT: t1 = 0x0014365f
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2f800
addi t1, t1, 2047          # EXPECT: t1 = 0xa1b2ffff
sh t1, 0(t0)               # EXPECT: mem[0x0400..0x0401] = 0xffff; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x1122ffff from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lh a0, 0(t0)               # EXPECT: a0 = 0xffffffff from mem[0x0400]

# Lane 2; only low halfword 0x0000 may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1600          # EXPECT: t1 = 0x00143640
slli t1, t1, 11            # EXPECT: t1 = 0xa1b20000
sh t1, 2(t0)               # EXPECT: mem[0x0402..0x0403] = 0x0000; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x00003344 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lh a0, 2(t0)               # EXPECT: a0 = 0x00000000 from mem[0x0402]

# Lane 2; only low halfword 0x7fff may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1615          # EXPECT: t1 = 0x0014364f
slli t1, t1, 11            # EXPECT: t1 = 0xa1b27800
addi t1, t1, 2047          # EXPECT: t1 = 0xa1b27fff
sh t1, 2(t0)               # EXPECT: mem[0x0402..0x0403] = 0x7fff; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x7fff3344 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lh a0, 2(t0)               # EXPECT: a0 = 0x00007fff from mem[0x0402]

# Lane 2; only low halfword 0x8000 may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1616          # EXPECT: t1 = 0x00143650
slli t1, t1, 11            # EXPECT: t1 = 0xa1b28000
sh t1, 2(t0)               # EXPECT: mem[0x0402..0x0403] = 0x8000; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x80003344 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lh a0, 2(t0)               # EXPECT: a0 = 0xffff8000 from mem[0x0402]

# Lane 2; only low halfword 0xffff may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1631          # EXPECT: t1 = 0x0014365f
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2f800
addi t1, t1, 2047          # EXPECT: t1 = 0xa1b2ffff
sh t1, 2(t0)               # EXPECT: mem[0x0402..0x0403] = 0xffff; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0xffff3344 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lh a0, 2(t0)               # EXPECT: a0 = 0xffffffff from mem[0x0402]
