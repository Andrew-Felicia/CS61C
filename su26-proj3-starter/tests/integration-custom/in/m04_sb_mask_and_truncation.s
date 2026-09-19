# Task 8: SB: all byte lanes; preserve other bytes and neighboring words.
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

# Lane 0; only low byte 0x00 of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 768           # EXPECT: t1 = 0xa1b2c300
sb t1, 0(t0)               # EXPECT: mem[0x0400..0x0400] = 0x00; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x11223300 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 0(t0)               # EXPECT: a0 = 0x00000000 from mem[0x0400]

# Lane 0; only low byte 0x7f of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 895           # EXPECT: t1 = 0xa1b2c37f
sb t1, 0(t0)               # EXPECT: mem[0x0400..0x0400] = 0x7f; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x1122337f from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 0(t0)               # EXPECT: a0 = 0x0000007f from mem[0x0400]

# Lane 0; only low byte 0x80 of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 896           # EXPECT: t1 = 0xa1b2c380
sb t1, 0(t0)               # EXPECT: mem[0x0400..0x0400] = 0x80; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x11223380 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 0(t0)               # EXPECT: a0 = 0xffffff80 from mem[0x0400]

# Lane 0; only low byte 0xff of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 1023          # EXPECT: t1 = 0xa1b2c3ff
sb t1, 0(t0)               # EXPECT: mem[0x0400..0x0400] = 0xff; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x112233ff from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 0(t0)               # EXPECT: a0 = 0xffffffff from mem[0x0400]

# Lane 1; only low byte 0x00 of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 768           # EXPECT: t1 = 0xa1b2c300
sb t1, 1(t0)               # EXPECT: mem[0x0401..0x0401] = 0x00; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x11220044 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 1(t0)               # EXPECT: a0 = 0x00000000 from mem[0x0401]

# Lane 1; only low byte 0x7f of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 895           # EXPECT: t1 = 0xa1b2c37f
sb t1, 1(t0)               # EXPECT: mem[0x0401..0x0401] = 0x7f; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x11227f44 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 1(t0)               # EXPECT: a0 = 0x0000007f from mem[0x0401]

# Lane 1; only low byte 0x80 of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 896           # EXPECT: t1 = 0xa1b2c380
sb t1, 1(t0)               # EXPECT: mem[0x0401..0x0401] = 0x80; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x11228044 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 1(t0)               # EXPECT: a0 = 0xffffff80 from mem[0x0401]

# Lane 1; only low byte 0xff of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 1023          # EXPECT: t1 = 0xa1b2c3ff
sb t1, 1(t0)               # EXPECT: mem[0x0401..0x0401] = 0xff; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x1122ff44 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 1(t0)               # EXPECT: a0 = 0xffffffff from mem[0x0401]

# Lane 2; only low byte 0x00 of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 768           # EXPECT: t1 = 0xa1b2c300
sb t1, 2(t0)               # EXPECT: mem[0x0402..0x0402] = 0x00; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x11003344 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 2(t0)               # EXPECT: a0 = 0x00000000 from mem[0x0402]

# Lane 2; only low byte 0x7f of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 895           # EXPECT: t1 = 0xa1b2c37f
sb t1, 2(t0)               # EXPECT: mem[0x0402..0x0402] = 0x7f; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x117f3344 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 2(t0)               # EXPECT: a0 = 0x0000007f from mem[0x0402]

# Lane 2; only low byte 0x80 of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 896           # EXPECT: t1 = 0xa1b2c380
sb t1, 2(t0)               # EXPECT: mem[0x0402..0x0402] = 0x80; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x11803344 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 2(t0)               # EXPECT: a0 = 0xffffff80 from mem[0x0402]

# Lane 2; only low byte 0xff of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 1023          # EXPECT: t1 = 0xa1b2c3ff
sb t1, 2(t0)               # EXPECT: mem[0x0402..0x0402] = 0xff; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x11ff3344 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 2(t0)               # EXPECT: a0 = 0xffffffff from mem[0x0402]

# Lane 3; only low byte 0x00 of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 768           # EXPECT: t1 = 0xa1b2c300
sb t1, 3(t0)               # EXPECT: mem[0x0403..0x0403] = 0x00; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x00223344 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 3(t0)               # EXPECT: a0 = 0x00000000 from mem[0x0403]

# Lane 3; only low byte 0x7f of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 895           # EXPECT: t1 = 0xa1b2c37f
sb t1, 3(t0)               # EXPECT: mem[0x0403..0x0403] = 0x7f; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x7f223344 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 3(t0)               # EXPECT: a0 = 0x0000007f from mem[0x0403]

# Lane 3; only low byte 0x80 of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 896           # EXPECT: t1 = 0xa1b2c380
sb t1, 3(t0)               # EXPECT: mem[0x0403..0x0403] = 0x80; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0x80223344 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 3(t0)               # EXPECT: a0 = 0xffffff80 from mem[0x0403]

# Lane 3; only low byte 0xff of source may be stored.
addi t1, x0, 68            # EXPECT: t1 = 0x00000044
slli t1, t1, 11            # EXPECT: t1 = 0x00022000
addi t1, t1, 1094          # EXPECT: t1 = 0x00022446
slli t1, t1, 11            # EXPECT: t1 = 0x11223000
addi t1, t1, 836           # EXPECT: t1 = 0x11223344
sw t1, 0(t0)               # EXPECT: mem[0x0400..0x0403] = 0x11223344; registers unchanged
addi t1, x0, 646           # EXPECT: t1 = 0x00000286
slli t1, t1, 11            # EXPECT: t1 = 0x00143000
addi t1, t1, 1624          # EXPECT: t1 = 0x00143658
slli t1, t1, 11            # EXPECT: t1 = 0xa1b2c000
addi t1, t1, 1023          # EXPECT: t1 = 0xa1b2c3ff
sb t1, 3(t0)               # EXPECT: mem[0x0403..0x0403] = 0xff; registers unchanged
lw t2, 0(t0)               # EXPECT: t2 = 0xff223344 from mem[0x0400]
lw s0, -4(t0)              # EXPECT: s0 = 0x55667788 from mem[0x03fc]
lw s1, 4(t0)               # EXPECT: s1 = 0x99aabbcc from mem[0x0404]
lb a0, 3(t0)               # EXPECT: a0 = 0xffffffff from mem[0x0403]
