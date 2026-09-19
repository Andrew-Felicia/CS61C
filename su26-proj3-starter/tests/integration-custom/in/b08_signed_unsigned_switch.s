# Task 7: Alternate signed/unsigned control on identical operands.
# Branch offsets are bytes relative to the branch instruction.
addi s0, x0, 0 # EXPECT: s0 = 0x00000000
addi t0, x0, -1 # EXPECT: t0 = 0xffffffff
addi t1, x0, 1 # EXPECT: t1 = 0x00000001
slli s0, s0, 1 # EXPECT: s0 = 0x00000000
blt t0, t1, switch_0_blt # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
switch_0_blt:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000000
addi t0, x0, -1 # EXPECT: t0 = 0xffffffff
addi t1, x0, 1 # EXPECT: t1 = 0x00000001
slli s0, s0, 1 # EXPECT: s0 = 0x00000000
bltu t0, t1, switch_0_bltu # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x00000001
switch_0_bltu:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000001
addi t0, x0, -1 # EXPECT: t0 = 0xffffffff
addi t1, x0, 1 # EXPECT: t1 = 0x00000001
slli s0, s0, 1 # EXPECT: s0 = 0x00000002
bge t0, t1, switch_0_bge # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x00000003
switch_0_bge:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000003
addi t0, x0, -1 # EXPECT: t0 = 0xffffffff
addi t1, x0, 1 # EXPECT: t1 = 0x00000001
slli s0, s0, 1 # EXPECT: s0 = 0x00000006
bgeu t0, t1, switch_0_bgeu # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
switch_0_bgeu:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000006
addi t0, x0, -1 # EXPECT: t0 = 0xffffffff
addi t1, x0, 1 # EXPECT: t1 = 0x00000001
slli s0, s0, 1 # EXPECT: s0 = 0x0000000c
beq t0, t1, switch_0_beq # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x0000000d
switch_0_beq:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x0000000d
addi t0, x0, -1 # EXPECT: t0 = 0xffffffff
addi t1, x0, 1 # EXPECT: t1 = 0x00000001
slli s0, s0, 1 # EXPECT: s0 = 0x0000001a
bne t0, t1, switch_0_bne # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
switch_0_bne:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x0000001a
addi t0, x0, 0 # EXPECT: t0 = 0x00000000
addi t1, x0, 512 # EXPECT: t1 = 0x00000200
slli t1, t1, 11 # EXPECT: t1 = 0x00100000
slli t1, t1, 11 # EXPECT: t1 = 0x80000000
slli s0, s0, 1 # EXPECT: s0 = 0x00000034
blt t0, t1, switch_1_blt # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x00000035
switch_1_blt:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000035
addi t0, x0, 0 # EXPECT: t0 = 0x00000000
addi t1, x0, 512 # EXPECT: t1 = 0x00000200
slli t1, t1, 11 # EXPECT: t1 = 0x00100000
slli t1, t1, 11 # EXPECT: t1 = 0x80000000
slli s0, s0, 1 # EXPECT: s0 = 0x0000006a
bltu t0, t1, switch_1_bltu # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
switch_1_bltu:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x0000006a
addi t0, x0, 0 # EXPECT: t0 = 0x00000000
addi t1, x0, 512 # EXPECT: t1 = 0x00000200
slli t1, t1, 11 # EXPECT: t1 = 0x00100000
slli t1, t1, 11 # EXPECT: t1 = 0x80000000
slli s0, s0, 1 # EXPECT: s0 = 0x000000d4
bge t0, t1, switch_1_bge # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
switch_1_bge:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x000000d4
addi t0, x0, 0 # EXPECT: t0 = 0x00000000
addi t1, x0, 512 # EXPECT: t1 = 0x00000200
slli t1, t1, 11 # EXPECT: t1 = 0x00100000
slli t1, t1, 11 # EXPECT: t1 = 0x80000000
slli s0, s0, 1 # EXPECT: s0 = 0x000001a8
bgeu t0, t1, switch_1_bgeu # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x000001a9
switch_1_bgeu:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x000001a9
addi t0, x0, 0 # EXPECT: t0 = 0x00000000
addi t1, x0, 512 # EXPECT: t1 = 0x00000200
slli t1, t1, 11 # EXPECT: t1 = 0x00100000
slli t1, t1, 11 # EXPECT: t1 = 0x80000000
slli s0, s0, 1 # EXPECT: s0 = 0x00000352
beq t0, t1, switch_1_beq # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x00000353
switch_1_beq:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000353
addi t0, x0, 0 # EXPECT: t0 = 0x00000000
addi t1, x0, 512 # EXPECT: t1 = 0x00000200
slli t1, t1, 11 # EXPECT: t1 = 0x00100000
slli t1, t1, 11 # EXPECT: t1 = 0x80000000
slli s0, s0, 1 # EXPECT: s0 = 0x000006a6
bne t0, t1, switch_1_bne # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
switch_1_bne:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x000006a6
addi t0, x0, 512 # EXPECT: t0 = 0x00000200
slli t0, t0, 11 # EXPECT: t0 = 0x00100000
slli t0, t0, 11 # EXPECT: t0 = 0x80000000
addi t1, x0, 511 # EXPECT: t1 = 0x000001ff
slli t1, t1, 11 # EXPECT: t1 = 0x000ff800
addi t1, t1, 2047 # EXPECT: t1 = 0x000fffff
slli t1, t1, 11 # EXPECT: t1 = 0x7ffff800
addi t1, t1, 2047 # EXPECT: t1 = 0x7fffffff
slli s0, s0, 1 # EXPECT: s0 = 0x00000d4c
blt t0, t1, switch_2_blt # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
switch_2_blt:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000d4c
addi t0, x0, 512 # EXPECT: t0 = 0x00000200
slli t0, t0, 11 # EXPECT: t0 = 0x00100000
slli t0, t0, 11 # EXPECT: t0 = 0x80000000
addi t1, x0, 511 # EXPECT: t1 = 0x000001ff
slli t1, t1, 11 # EXPECT: t1 = 0x000ff800
addi t1, t1, 2047 # EXPECT: t1 = 0x000fffff
slli t1, t1, 11 # EXPECT: t1 = 0x7ffff800
addi t1, t1, 2047 # EXPECT: t1 = 0x7fffffff
slli s0, s0, 1 # EXPECT: s0 = 0x00001a98
bltu t0, t1, switch_2_bltu # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x00001a99
switch_2_bltu:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00001a99
addi t0, x0, 512 # EXPECT: t0 = 0x00000200
slli t0, t0, 11 # EXPECT: t0 = 0x00100000
slli t0, t0, 11 # EXPECT: t0 = 0x80000000
addi t1, x0, 511 # EXPECT: t1 = 0x000001ff
slli t1, t1, 11 # EXPECT: t1 = 0x000ff800
addi t1, t1, 2047 # EXPECT: t1 = 0x000fffff
slli t1, t1, 11 # EXPECT: t1 = 0x7ffff800
addi t1, t1, 2047 # EXPECT: t1 = 0x7fffffff
slli s0, s0, 1 # EXPECT: s0 = 0x00003532
bge t0, t1, switch_2_bge # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x00003533
switch_2_bge:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00003533
addi t0, x0, 512 # EXPECT: t0 = 0x00000200
slli t0, t0, 11 # EXPECT: t0 = 0x00100000
slli t0, t0, 11 # EXPECT: t0 = 0x80000000
addi t1, x0, 511 # EXPECT: t1 = 0x000001ff
slli t1, t1, 11 # EXPECT: t1 = 0x000ff800
addi t1, t1, 2047 # EXPECT: t1 = 0x000fffff
slli t1, t1, 11 # EXPECT: t1 = 0x7ffff800
addi t1, t1, 2047 # EXPECT: t1 = 0x7fffffff
slli s0, s0, 1 # EXPECT: s0 = 0x00006a66
bgeu t0, t1, switch_2_bgeu # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
switch_2_bgeu:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00006a66
addi t0, x0, 512 # EXPECT: t0 = 0x00000200
slli t0, t0, 11 # EXPECT: t0 = 0x00100000
slli t0, t0, 11 # EXPECT: t0 = 0x80000000
addi t1, x0, 511 # EXPECT: t1 = 0x000001ff
slli t1, t1, 11 # EXPECT: t1 = 0x000ff800
addi t1, t1, 2047 # EXPECT: t1 = 0x000fffff
slli t1, t1, 11 # EXPECT: t1 = 0x7ffff800
addi t1, t1, 2047 # EXPECT: t1 = 0x7fffffff
slli s0, s0, 1 # EXPECT: s0 = 0x0000d4cc
beq t0, t1, switch_2_beq # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x0000d4cd
switch_2_beq:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x0000d4cd
addi t0, x0, 512 # EXPECT: t0 = 0x00000200
slli t0, t0, 11 # EXPECT: t0 = 0x00100000
slli t0, t0, 11 # EXPECT: t0 = 0x80000000
addi t1, x0, 511 # EXPECT: t1 = 0x000001ff
slli t1, t1, 11 # EXPECT: t1 = 0x000ff800
addi t1, t1, 2047 # EXPECT: t1 = 0x000fffff
slli t1, t1, 11 # EXPECT: t1 = 0x7ffff800
addi t1, t1, 2047 # EXPECT: t1 = 0x7fffffff
slli s0, s0, 1 # EXPECT: s0 = 0x0001a99a
bne t0, t1, switch_2_bne # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
switch_2_bne:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x0001a99a
addi t0, x0, 123 # EXPECT: t0 = 0x0000007b
addi t1, x0, 123 # EXPECT: t1 = 0x0000007b
slli s0, s0, 1 # EXPECT: s0 = 0x00035334
blt t0, t1, switch_3_blt # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x00035335
switch_3_blt:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00035335
addi t0, x0, 123 # EXPECT: t0 = 0x0000007b
addi t1, x0, 123 # EXPECT: t1 = 0x0000007b
slli s0, s0, 1 # EXPECT: s0 = 0x0006a66a
bltu t0, t1, switch_3_bltu # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x0006a66b
switch_3_bltu:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x0006a66b
addi t0, x0, 123 # EXPECT: t0 = 0x0000007b
addi t1, x0, 123 # EXPECT: t1 = 0x0000007b
slli s0, s0, 1 # EXPECT: s0 = 0x000d4cd6
bge t0, t1, switch_3_bge # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
switch_3_bge:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x000d4cd6
addi t0, x0, 123 # EXPECT: t0 = 0x0000007b
addi t1, x0, 123 # EXPECT: t1 = 0x0000007b
slli s0, s0, 1 # EXPECT: s0 = 0x001a99ac
bgeu t0, t1, switch_3_bgeu # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
switch_3_bgeu:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x001a99ac
addi t0, x0, 123 # EXPECT: t0 = 0x0000007b
addi t1, x0, 123 # EXPECT: t1 = 0x0000007b
slli s0, s0, 1 # EXPECT: s0 = 0x00353358
beq t0, t1, switch_3_beq # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
switch_3_beq:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00353358
addi t0, x0, 123 # EXPECT: t0 = 0x0000007b
addi t1, x0, 123 # EXPECT: t1 = 0x0000007b
slli s0, s0, 1 # EXPECT: s0 = 0x006a66b0
bne t0, t1, switch_3_bne # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x006a66b1
switch_3_bne:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x006a66b1

# Final checkpoints:
# s0 = 0x006a66b1
