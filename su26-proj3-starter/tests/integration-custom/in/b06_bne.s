# Task 7: BNE: equality, ordering, sign boundaries, both outcomes.
# Branch offsets are bytes relative to the branch instruction.
addi s0, x0, 0 # EXPECT: s0 = 0x00000000

# Case 1: 0x00000000 versus 0x00000000.
addi t0, x0, 0 # EXPECT: t0 = 0x00000000
addi t1, x0, 0 # EXPECT: t1 = 0x00000000
slli s0, s0, 1 # EXPECT: s0 = 0x00000000
bne t0, t1, case_1_end # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x00000001
case_1_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000001

# Case 2: 0x00000001 versus 0x00000001.
addi t0, x0, 1 # EXPECT: t0 = 0x00000001
addi t1, x0, 1 # EXPECT: t1 = 0x00000001
slli s0, s0, 1 # EXPECT: s0 = 0x00000002
bne t0, t1, case_2_end # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x00000003
case_2_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000003

# Case 3: 0x00000001 versus 0x00000002.
addi t0, x0, 1 # EXPECT: t0 = 0x00000001
addi t1, x0, 2 # EXPECT: t1 = 0x00000002
slli s0, s0, 1 # EXPECT: s0 = 0x00000006
bne t0, t1, case_3_end # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
case_3_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000006

# Case 4: 0x00000002 versus 0x00000001.
addi t0, x0, 2 # EXPECT: t0 = 0x00000002
addi t1, x0, 1 # EXPECT: t1 = 0x00000001
slli s0, s0, 1 # EXPECT: s0 = 0x0000000c
bne t0, t1, case_4_end # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
case_4_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x0000000c

# Case 5: 0xffffffff versus 0x00000000.
addi t0, x0, -1 # EXPECT: t0 = 0xffffffff
addi t1, x0, 0 # EXPECT: t1 = 0x00000000
slli s0, s0, 1 # EXPECT: s0 = 0x00000018
bne t0, t1, case_5_end # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
case_5_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000018

# Case 6: 0x00000000 versus 0xffffffff.
addi t0, x0, 0 # EXPECT: t0 = 0x00000000
addi t1, x0, -1 # EXPECT: t1 = 0xffffffff
slli s0, s0, 1 # EXPECT: s0 = 0x00000030
bne t0, t1, case_6_end # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
case_6_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000030

# Case 7: 0xfffffffe versus 0xffffffff.
addi t0, x0, -2 # EXPECT: t0 = 0xfffffffe
addi t1, x0, -1 # EXPECT: t1 = 0xffffffff
slli s0, s0, 1 # EXPECT: s0 = 0x00000060
bne t0, t1, case_7_end # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
case_7_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000060

# Case 8: 0xffffffff versus 0xfffffffe.
addi t0, x0, -1 # EXPECT: t0 = 0xffffffff
addi t1, x0, -2 # EXPECT: t1 = 0xfffffffe
slli s0, s0, 1 # EXPECT: s0 = 0x000000c0
bne t0, t1, case_8_end # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
case_8_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x000000c0

# Case 9: 0x80000000 versus 0x7fffffff.
addi t0, x0, 512 # EXPECT: t0 = 0x00000200
slli t0, t0, 11 # EXPECT: t0 = 0x00100000
slli t0, t0, 11 # EXPECT: t0 = 0x80000000
addi t1, x0, 511 # EXPECT: t1 = 0x000001ff
slli t1, t1, 11 # EXPECT: t1 = 0x000ff800
addi t1, t1, 2047 # EXPECT: t1 = 0x000fffff
slli t1, t1, 11 # EXPECT: t1 = 0x7ffff800
addi t1, t1, 2047 # EXPECT: t1 = 0x7fffffff
slli s0, s0, 1 # EXPECT: s0 = 0x00000180
bne t0, t1, case_9_end # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
case_9_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000180

# Case 10: 0x7fffffff versus 0x80000000.
addi t0, x0, 511 # EXPECT: t0 = 0x000001ff
slli t0, t0, 11 # EXPECT: t0 = 0x000ff800
addi t0, t0, 2047 # EXPECT: t0 = 0x000fffff
slli t0, t0, 11 # EXPECT: t0 = 0x7ffff800
addi t0, t0, 2047 # EXPECT: t0 = 0x7fffffff
addi t1, x0, 512 # EXPECT: t1 = 0x00000200
slli t1, t1, 11 # EXPECT: t1 = 0x00100000
slli t1, t1, 11 # EXPECT: t1 = 0x80000000
slli s0, s0, 1 # EXPECT: s0 = 0x00000300
bne t0, t1, case_10_end # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
case_10_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000300

# Case 11: 0x80000000 versus 0x00000001.
addi t0, x0, 512 # EXPECT: t0 = 0x00000200
slli t0, t0, 11 # EXPECT: t0 = 0x00100000
slli t0, t0, 11 # EXPECT: t0 = 0x80000000
addi t1, x0, 1 # EXPECT: t1 = 0x00000001
slli s0, s0, 1 # EXPECT: s0 = 0x00000600
bne t0, t1, case_11_end # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
case_11_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000600

# Case 12: 0x00000001 versus 0x80000000.
addi t0, x0, 1 # EXPECT: t0 = 0x00000001
addi t1, x0, 512 # EXPECT: t1 = 0x00000200
slli t1, t1, 11 # EXPECT: t1 = 0x00100000
slli t1, t1, 11 # EXPECT: t1 = 0x80000000
slli s0, s0, 1 # EXPECT: s0 = 0x00000c00
bne t0, t1, case_12_end # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
case_12_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00000c00

# Case 13: 0x80000000 versus 0x80000000.
addi t0, x0, 512 # EXPECT: t0 = 0x00000200
slli t0, t0, 11 # EXPECT: t0 = 0x00100000
slli t0, t0, 11 # EXPECT: t0 = 0x80000000
addi t1, x0, 512 # EXPECT: t1 = 0x00000200
slli t1, t1, 11 # EXPECT: t1 = 0x00100000
slli t1, t1, 11 # EXPECT: t1 = 0x80000000
slli s0, s0, 1 # EXPECT: s0 = 0x00001800
bne t0, t1, case_13_end # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x00001801
case_13_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00001801

# Case 14: 0xaaaaaaaa versus 0xaaaaaaab.
addi t0, x0, 682 # EXPECT: t0 = 0x000002aa
slli t0, t0, 11 # EXPECT: t0 = 0x00155000
addi t0, t0, 1365 # EXPECT: t0 = 0x00155555
slli t0, t0, 11 # EXPECT: t0 = 0xaaaaa800
addi t0, t0, 682 # EXPECT: t0 = 0xaaaaaaaa
addi t1, x0, 682 # EXPECT: t1 = 0x000002aa
slli t1, t1, 11 # EXPECT: t1 = 0x00155000
addi t1, t1, 1365 # EXPECT: t1 = 0x00155555
slli t1, t1, 11 # EXPECT: t1 = 0xaaaaa800
addi t1, t1, 683 # EXPECT: t1 = 0xaaaaaaab
slli s0, s0, 1 # EXPECT: s0 = 0x00003002
bne t0, t1, case_14_end # TAKEN; offset +8 # EXPECT: TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: SKIPPED on correct execution
case_14_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00003002

# Case 15: 0xaaaaaaaa versus 0xaaaaaaaa.
addi t0, x0, 682 # EXPECT: t0 = 0x000002aa
slli t0, t0, 11 # EXPECT: t0 = 0x00155000
addi t0, t0, 1365 # EXPECT: t0 = 0x00155555
slli t0, t0, 11 # EXPECT: t0 = 0xaaaaa800
addi t0, t0, 682 # EXPECT: t0 = 0xaaaaaaaa
addi t1, x0, 682 # EXPECT: t1 = 0x000002aa
slli t1, t1, 11 # EXPECT: t1 = 0x00155000
addi t1, t1, 1365 # EXPECT: t1 = 0x00155555
slli t1, t1, 11 # EXPECT: t1 = 0xaaaaa800
addi t1, t1, 682 # EXPECT: t1 = 0xaaaaaaaa
slli s0, s0, 1 # EXPECT: s0 = 0x00006004
bne t0, t1, case_15_end # NOT TAKEN; offset +8 # EXPECT: NOT TAKEN, offset +8
ori s0, s0, 1 # set the low signature bit only on fall-through # EXPECT: s0 = 0x00006005
case_15_end:
addi t2, s0, 0 # expose cumulative path signature # EXPECT: t2 = 0x00006005

# Final checkpoints:
# s0 = 0x00006005
