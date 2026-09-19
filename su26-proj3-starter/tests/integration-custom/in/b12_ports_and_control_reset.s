# Task 7: High register indices, x0 sources, and I/R operations after branches.
# Branch offsets are bytes relative to the branch instruction.
addi s0, x0, 0 # EXPECT: s0 = 0x00000000
addi x1, x0, 13 # EXPECT: x1 = 0x0000000d
addi x17, x0, 14 # EXPECT: x17 = 0x0000000e
addi x31, x0, 13 # EXPECT: x31 = 0x0000000d
beq x1, x31, ports_0 # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
addi s0, s0, 1 # EXPECT: SKIPPED on correct execution
ports_0:
addi t0, x0, 7 # restore I-type ASel/BSel/ImmSel/RegWEn # EXPECT: t0 = 0x00000007
addi t1, x0, 3 # EXPECT: t1 = 0x00000003
add t2, t0, t1 # expected 10; restore R-type controls # EXPECT: t2 = 0x0000000a
sub s1, t2, t1 # expected 7 # EXPECT: s1 = 0x00000007
bne x1, x17, ports_1 # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
addi s0, s0, 1 # EXPECT: SKIPPED on correct execution
ports_1:
addi t0, x0, 7 # restore I-type ASel/BSel/ImmSel/RegWEn # EXPECT: t0 = 0x00000007
addi t1, x0, 3 # EXPECT: t1 = 0x00000003
add t2, t0, t1 # expected 10; restore R-type controls # EXPECT: t2 = 0x0000000a
sub s1, t2, t1 # expected 7 # EXPECT: s1 = 0x00000007
blt x17, x1, ports_2 # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
addi s0, s0, 1 # EXPECT: s0 = 0x00000001
ports_2:
addi t0, x0, 7 # restore I-type ASel/BSel/ImmSel/RegWEn # EXPECT: t0 = 0x00000007
addi t1, x0, 3 # EXPECT: t1 = 0x00000003
add t2, t0, t1 # expected 10; restore R-type controls # EXPECT: t2 = 0x0000000a
sub s1, t2, t1 # expected 7 # EXPECT: s1 = 0x00000007
bge x31, x17, ports_3 # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
addi s0, s0, 1 # EXPECT: s0 = 0x00000002
ports_3:
addi t0, x0, 7 # restore I-type ASel/BSel/ImmSel/RegWEn # EXPECT: t0 = 0x00000007
addi t1, x0, 3 # EXPECT: t1 = 0x00000003
add t2, t0, t1 # expected 10; restore R-type controls # EXPECT: t2 = 0x0000000a
sub s1, t2, t1 # expected 7 # EXPECT: s1 = 0x00000007
bltu x0, x17, ports_4 # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
addi s0, s0, 1 # EXPECT: SKIPPED on correct execution
ports_4:
addi t0, x0, 7 # restore I-type ASel/BSel/ImmSel/RegWEn # EXPECT: t0 = 0x00000007
addi t1, x0, 3 # EXPECT: t1 = 0x00000003
add t2, t0, t1 # expected 10; restore R-type controls # EXPECT: t2 = 0x0000000a
sub s1, t2, t1 # expected 7 # EXPECT: s1 = 0x00000007
bgeu x0, x31, ports_5 # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
addi s0, s0, 1 # EXPECT: s0 = 0x00000003
ports_5:
addi t0, x0, 7 # restore I-type ASel/BSel/ImmSel/RegWEn # EXPECT: t0 = 0x00000007
addi t1, x0, 3 # EXPECT: t1 = 0x00000003
add t2, t0, t1 # expected 10; restore R-type controls # EXPECT: t2 = 0x0000000a
sub s1, t2, t1 # expected 7 # EXPECT: s1 = 0x00000007
beq x31, x31, ports_6 # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
addi s0, s0, 1 # EXPECT: SKIPPED on correct execution
ports_6:
addi t0, x0, 7 # restore I-type ASel/BSel/ImmSel/RegWEn # EXPECT: t0 = 0x00000007
addi t1, x0, 3 # EXPECT: t1 = 0x00000003
add t2, t0, t1 # expected 10; restore R-type controls # EXPECT: t2 = 0x0000000a
sub s1, t2, t1 # expected 7 # EXPECT: s1 = 0x00000007
bne x31, x31, ports_7 # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
addi s0, s0, 1 # EXPECT: s0 = 0x00000004
ports_7:
addi t0, x0, 7 # restore I-type ASel/BSel/ImmSel/RegWEn # EXPECT: t0 = 0x00000007
addi t1, x0, 3 # EXPECT: t1 = 0x00000003
add t2, t0, t1 # expected 10; restore R-type controls # EXPECT: t2 = 0x0000000a
sub s1, t2, t1 # expected 7 # EXPECT: s1 = 0x00000007

# Final checkpoints:
# s0 = 0x00000004
# t2 = 0x0000000a
# s1 = 0x00000007
