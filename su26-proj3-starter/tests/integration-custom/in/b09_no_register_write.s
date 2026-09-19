# Task 7: Both taken and untaken branches must leave register sentinels unchanged.
# Branch offsets are bytes relative to the branch instruction.
addi t0, x0, 2 # EXPECT: t0 = 0x00000002
addi t1, x0, 2 # EXPECT: t1 = 0x00000002
addi s0, x0, 1234 # EXPECT: s0 = 0x000004d2
addi a2, x0, 777 # EXPECT: a2 = 0x00000309
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
beq t0, t1, guard8_0_0 # offset +8: instruction bits [11:7] select x8 (s0) # EXPECT: TAKEN, offset +8
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
guard8_0_0:
addi s1, s0, 0 # expected 1234 # EXPECT: s1 = 0x000004d2
beq t0, t1, guard12_0_0 # offset +12: bits [11:7] select x12 (a2) # EXPECT: TAKEN, offset +12
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
guard12_0_0:
addi a1, a2, 0 # expected 777 # EXPECT: a1 = 0x00000309
addi t0, x0, 1 # EXPECT: t0 = 0x00000001
addi t1, x0, 2 # EXPECT: t1 = 0x00000002
addi s0, x0, 1234 # EXPECT: s0 = 0x000004d2
addi a2, x0, 777 # EXPECT: a2 = 0x00000309
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
beq t0, t1, guard8_0_1 # offset +8: instruction bits [11:7] select x8 (s0) # EXPECT: NOT TAKEN, offset +8
addi t2, t2, 1 # EXPECT: t2 = 0x00000001
guard8_0_1:
addi s1, s0, 0 # expected 1234 # EXPECT: s1 = 0x000004d2
beq t0, t1, guard12_0_1 # offset +12: bits [11:7] select x12 (a2) # EXPECT: NOT TAKEN, offset +12
addi t2, t2, 1 # EXPECT: t2 = 0x00000002
addi t2, t2, 1 # EXPECT: t2 = 0x00000003
guard12_0_1:
addi a1, a2, 0 # expected 777 # EXPECT: a1 = 0x00000309
addi t0, x0, 2 # EXPECT: t0 = 0x00000002
addi t1, x0, 2 # EXPECT: t1 = 0x00000002
addi s0, x0, 1234 # EXPECT: s0 = 0x000004d2
addi a2, x0, 777 # EXPECT: a2 = 0x00000309
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
bge t0, t1, guard8_1_0 # offset +8: instruction bits [11:7] select x8 (s0) # EXPECT: TAKEN, offset +8
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
guard8_1_0:
addi s1, s0, 0 # expected 1234 # EXPECT: s1 = 0x000004d2
bge t0, t1, guard12_1_0 # offset +12: bits [11:7] select x12 (a2) # EXPECT: TAKEN, offset +12
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
guard12_1_0:
addi a1, a2, 0 # expected 777 # EXPECT: a1 = 0x00000309
addi t0, x0, 1 # EXPECT: t0 = 0x00000001
addi t1, x0, 2 # EXPECT: t1 = 0x00000002
addi s0, x0, 1234 # EXPECT: s0 = 0x000004d2
addi a2, x0, 777 # EXPECT: a2 = 0x00000309
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
bge t0, t1, guard8_1_1 # offset +8: instruction bits [11:7] select x8 (s0) # EXPECT: NOT TAKEN, offset +8
addi t2, t2, 1 # EXPECT: t2 = 0x00000001
guard8_1_1:
addi s1, s0, 0 # expected 1234 # EXPECT: s1 = 0x000004d2
bge t0, t1, guard12_1_1 # offset +12: bits [11:7] select x12 (a2) # EXPECT: NOT TAKEN, offset +12
addi t2, t2, 1 # EXPECT: t2 = 0x00000002
addi t2, t2, 1 # EXPECT: t2 = 0x00000003
guard12_1_1:
addi a1, a2, 0 # expected 777 # EXPECT: a1 = 0x00000309
addi t0, x0, 2 # EXPECT: t0 = 0x00000002
addi t1, x0, 2 # EXPECT: t1 = 0x00000002
addi s0, x0, 1234 # EXPECT: s0 = 0x000004d2
addi a2, x0, 777 # EXPECT: a2 = 0x00000309
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
bgeu t0, t1, guard8_2_0 # offset +8: instruction bits [11:7] select x8 (s0) # EXPECT: TAKEN, offset +8
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
guard8_2_0:
addi s1, s0, 0 # expected 1234 # EXPECT: s1 = 0x000004d2
bgeu t0, t1, guard12_2_0 # offset +12: bits [11:7] select x12 (a2) # EXPECT: TAKEN, offset +12
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
guard12_2_0:
addi a1, a2, 0 # expected 777 # EXPECT: a1 = 0x00000309
addi t0, x0, 1 # EXPECT: t0 = 0x00000001
addi t1, x0, 2 # EXPECT: t1 = 0x00000002
addi s0, x0, 1234 # EXPECT: s0 = 0x000004d2
addi a2, x0, 777 # EXPECT: a2 = 0x00000309
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
bgeu t0, t1, guard8_2_1 # offset +8: instruction bits [11:7] select x8 (s0) # EXPECT: NOT TAKEN, offset +8
addi t2, t2, 1 # EXPECT: t2 = 0x00000001
guard8_2_1:
addi s1, s0, 0 # expected 1234 # EXPECT: s1 = 0x000004d2
bgeu t0, t1, guard12_2_1 # offset +12: bits [11:7] select x12 (a2) # EXPECT: NOT TAKEN, offset +12
addi t2, t2, 1 # EXPECT: t2 = 0x00000002
addi t2, t2, 1 # EXPECT: t2 = 0x00000003
guard12_2_1:
addi a1, a2, 0 # expected 777 # EXPECT: a1 = 0x00000309
addi t0, x0, 1 # EXPECT: t0 = 0x00000001
addi t1, x0, 2 # EXPECT: t1 = 0x00000002
addi s0, x0, 1234 # EXPECT: s0 = 0x000004d2
addi a2, x0, 777 # EXPECT: a2 = 0x00000309
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
blt t0, t1, guard8_3_0 # offset +8: instruction bits [11:7] select x8 (s0) # EXPECT: TAKEN, offset +8
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
guard8_3_0:
addi s1, s0, 0 # expected 1234 # EXPECT: s1 = 0x000004d2
blt t0, t1, guard12_3_0 # offset +12: bits [11:7] select x12 (a2) # EXPECT: TAKEN, offset +12
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
guard12_3_0:
addi a1, a2, 0 # expected 777 # EXPECT: a1 = 0x00000309
addi t0, x0, 2 # EXPECT: t0 = 0x00000002
addi t1, x0, 2 # EXPECT: t1 = 0x00000002
addi s0, x0, 1234 # EXPECT: s0 = 0x000004d2
addi a2, x0, 777 # EXPECT: a2 = 0x00000309
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
blt t0, t1, guard8_3_1 # offset +8: instruction bits [11:7] select x8 (s0) # EXPECT: NOT TAKEN, offset +8
addi t2, t2, 1 # EXPECT: t2 = 0x00000001
guard8_3_1:
addi s1, s0, 0 # expected 1234 # EXPECT: s1 = 0x000004d2
blt t0, t1, guard12_3_1 # offset +12: bits [11:7] select x12 (a2) # EXPECT: NOT TAKEN, offset +12
addi t2, t2, 1 # EXPECT: t2 = 0x00000002
addi t2, t2, 1 # EXPECT: t2 = 0x00000003
guard12_3_1:
addi a1, a2, 0 # expected 777 # EXPECT: a1 = 0x00000309
addi t0, x0, 1 # EXPECT: t0 = 0x00000001
addi t1, x0, 2 # EXPECT: t1 = 0x00000002
addi s0, x0, 1234 # EXPECT: s0 = 0x000004d2
addi a2, x0, 777 # EXPECT: a2 = 0x00000309
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
bltu t0, t1, guard8_4_0 # offset +8: instruction bits [11:7] select x8 (s0) # EXPECT: TAKEN, offset +8
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
guard8_4_0:
addi s1, s0, 0 # expected 1234 # EXPECT: s1 = 0x000004d2
bltu t0, t1, guard12_4_0 # offset +12: bits [11:7] select x12 (a2) # EXPECT: TAKEN, offset +12
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
guard12_4_0:
addi a1, a2, 0 # expected 777 # EXPECT: a1 = 0x00000309
addi t0, x0, 2 # EXPECT: t0 = 0x00000002
addi t1, x0, 2 # EXPECT: t1 = 0x00000002
addi s0, x0, 1234 # EXPECT: s0 = 0x000004d2
addi a2, x0, 777 # EXPECT: a2 = 0x00000309
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
bltu t0, t1, guard8_4_1 # offset +8: instruction bits [11:7] select x8 (s0) # EXPECT: NOT TAKEN, offset +8
addi t2, t2, 1 # EXPECT: t2 = 0x00000001
guard8_4_1:
addi s1, s0, 0 # expected 1234 # EXPECT: s1 = 0x000004d2
bltu t0, t1, guard12_4_1 # offset +12: bits [11:7] select x12 (a2) # EXPECT: NOT TAKEN, offset +12
addi t2, t2, 1 # EXPECT: t2 = 0x00000002
addi t2, t2, 1 # EXPECT: t2 = 0x00000003
guard12_4_1:
addi a1, a2, 0 # expected 777 # EXPECT: a1 = 0x00000309
addi t0, x0, 2 # EXPECT: t0 = 0x00000002
addi t1, x0, 2 # EXPECT: t1 = 0x00000002
addi s0, x0, 1234 # EXPECT: s0 = 0x000004d2
addi a2, x0, 777 # EXPECT: a2 = 0x00000309
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
bne t0, t1, guard8_5_0 # offset +8: instruction bits [11:7] select x8 (s0) # EXPECT: NOT TAKEN, offset +8
addi t2, t2, 1 # EXPECT: t2 = 0x00000001
guard8_5_0:
addi s1, s0, 0 # expected 1234 # EXPECT: s1 = 0x000004d2
bne t0, t1, guard12_5_0 # offset +12: bits [11:7] select x12 (a2) # EXPECT: NOT TAKEN, offset +12
addi t2, t2, 1 # EXPECT: t2 = 0x00000002
addi t2, t2, 1 # EXPECT: t2 = 0x00000003
guard12_5_0:
addi a1, a2, 0 # expected 777 # EXPECT: a1 = 0x00000309
addi t0, x0, 1 # EXPECT: t0 = 0x00000001
addi t1, x0, 2 # EXPECT: t1 = 0x00000002
addi s0, x0, 1234 # EXPECT: s0 = 0x000004d2
addi a2, x0, 777 # EXPECT: a2 = 0x00000309
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
bne t0, t1, guard8_5_1 # offset +8: instruction bits [11:7] select x8 (s0) # EXPECT: TAKEN, offset +8
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
guard8_5_1:
addi s1, s0, 0 # expected 1234 # EXPECT: s1 = 0x000004d2
bne t0, t1, guard12_5_1 # offset +12: bits [11:7] select x12 (a2) # EXPECT: TAKEN, offset +12
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
addi t2, t2, 1 # EXPECT: SKIPPED on correct execution
guard12_5_1:
addi a1, a2, 0 # expected 777 # EXPECT: a1 = 0x00000309

# Final checkpoints:
# s1 = 0x000004d2
# a1 = 0x00000309
