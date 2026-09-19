# Task 7: Finite backward loops for all six branches; each changes from taken to untaken.
# Branch offsets are bytes relative to the branch instruction.

# beq: 2 iterations. Branch offset -8; x25 must stay 777.
addi t0, x0, 1 # EXPECT: t0 = 0x00000001
addi t1, x0, 0 # EXPECT: t1 = 0x00000000
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
addi x25, x0, 777 # EXPECT: x25 = 0x00000309
loop_beq:
addi t0, t0, -1 # EXPECT: t0 = 0x00000000 / t0 = 0xffffffff
addi t2, t2, 1 # EXPECT: t2 = 0x00000001 / t2 = 0x00000002
beq t0, t1, loop_beq # negative immediate, taken then not taken # EXPECT: TAKEN, offset -8 / NOT TAKEN, offset -8
addi a0, t2, 0 # expected 2 # EXPECT: a0 = 0x00000002
addi s1, x25, 0 # expected 777; branch must not write x25 # EXPECT: s1 = 0x00000309

# bne: 3 iterations. Branch offset -8; x25 must stay 777.
addi t0, x0, 3 # EXPECT: t0 = 0x00000003
addi t1, x0, 0 # EXPECT: t1 = 0x00000000
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
addi x25, x0, 777 # EXPECT: x25 = 0x00000309
loop_bne:
addi t0, t0, -1 # EXPECT: t0 = 0x00000002 / t0 = 0x00000001 / t0 = 0x00000000
addi t2, t2, 1 # EXPECT: t2 = 0x00000001 / t2 = 0x00000002 / t2 = 0x00000003
bne t0, t1, loop_bne # negative immediate, taken then not taken # EXPECT: TAKEN, offset -8 / NOT TAKEN, offset -8
addi a1, t2, 0 # expected 3 # EXPECT: a1 = 0x00000003
addi s1, x25, 0 # expected 777; branch must not write x25 # EXPECT: s1 = 0x00000309

# blt: 3 iterations. Branch offset -8; x25 must stay 777.
addi t0, x0, -3 # EXPECT: t0 = 0xfffffffd
addi t1, x0, 0 # EXPECT: t1 = 0x00000000
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
addi x25, x0, 777 # EXPECT: x25 = 0x00000309
loop_blt:
addi t0, t0, 1 # EXPECT: t0 = 0xfffffffe / t0 = 0xffffffff / t0 = 0x00000000
addi t2, t2, 1 # EXPECT: t2 = 0x00000001 / t2 = 0x00000002 / t2 = 0x00000003
blt t0, t1, loop_blt # negative immediate, taken then not taken # EXPECT: TAKEN, offset -8 / NOT TAKEN, offset -8
addi a2, t2, 0 # expected 3 # EXPECT: a2 = 0x00000003
addi s1, x25, 0 # expected 777; branch must not write x25 # EXPECT: s1 = 0x00000309

# bge: 3 iterations. Branch offset -8; x25 must stay 777.
addi t0, x0, 2 # EXPECT: t0 = 0x00000002
addi t1, x0, 0 # EXPECT: t1 = 0x00000000
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
addi x25, x0, 777 # EXPECT: x25 = 0x00000309
loop_bge:
addi t0, t0, -1 # EXPECT: t0 = 0x00000001 / t0 = 0x00000000 / t0 = 0xffffffff
addi t2, t2, 1 # EXPECT: t2 = 0x00000001 / t2 = 0x00000002 / t2 = 0x00000003
bge t0, t1, loop_bge # negative immediate, taken then not taken # EXPECT: TAKEN, offset -8 / NOT TAKEN, offset -8
addi a3, t2, 0 # expected 3 # EXPECT: a3 = 0x00000003
addi s1, x25, 0 # expected 777; branch must not write x25 # EXPECT: s1 = 0x00000309

# bltu: 3 iterations. Branch offset -8; x25 must stay 777.
addi t0, x0, 0 # EXPECT: t0 = 0x00000000
addi t1, x0, 3 # EXPECT: t1 = 0x00000003
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
addi x25, x0, 777 # EXPECT: x25 = 0x00000309
loop_bltu:
addi t0, t0, 1 # EXPECT: t0 = 0x00000001 / t0 = 0x00000002 / t0 = 0x00000003
addi t2, t2, 1 # EXPECT: t2 = 0x00000001 / t2 = 0x00000002 / t2 = 0x00000003
bltu t0, t1, loop_bltu # negative immediate, taken then not taken # EXPECT: TAKEN, offset -8 / NOT TAKEN, offset -8
addi a4, t2, 0 # expected 3 # EXPECT: a4 = 0x00000003
addi s1, x25, 0 # expected 777; branch must not write x25 # EXPECT: s1 = 0x00000309

# bgeu: 3 iterations. Branch offset -8; x25 must stay 777.
addi t0, x0, 3 # EXPECT: t0 = 0x00000003
addi t1, x0, 1 # EXPECT: t1 = 0x00000001
addi t2, x0, 0 # EXPECT: t2 = 0x00000000
addi x25, x0, 777 # EXPECT: x25 = 0x00000309
loop_bgeu:
addi t0, t0, -1 # EXPECT: t0 = 0x00000002 / t0 = 0x00000001 / t0 = 0x00000000
addi t2, t2, 1 # EXPECT: t2 = 0x00000001 / t2 = 0x00000002 / t2 = 0x00000003
bgeu t0, t1, loop_bgeu # negative immediate, taken then not taken # EXPECT: TAKEN, offset -8 / NOT TAKEN, offset -8
addi a5, t2, 0 # expected 3 # EXPECT: a5 = 0x00000003
addi s1, x25, 0 # expected 777; branch must not write x25 # EXPECT: s1 = 0x00000309

# Final checkpoints:
# a0 = 0x00000002
# a1 = 0x00000003
# a2 = 0x00000003
# a3 = 0x00000003
# a4 = 0x00000003
# a5 = 0x00000003
# s1 = 0x00000309
