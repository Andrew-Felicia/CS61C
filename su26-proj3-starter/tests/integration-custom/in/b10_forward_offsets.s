# Task 7: Exact positive offsets; skipped filler must not change a0.
# Branch offsets are bytes relative to the branch instruction.
addi a0, x0, 0 # EXPECT: a0 = 0x00000000
addi s0, x0, 0 # EXPECT: s0 = 0x00000000

# Taken BEQ with exactly +8 byte displacement.
beq x0, x0, forward_0 # offset +8 # EXPECT: TAKEN, offset +8
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
forward_0:
addi s0, s0, 1 # EXPECT: s0 = 0x00000001

# Taken BEQ with exactly +12 byte displacement.
beq x0, x0, forward_1 # offset +12 # EXPECT: TAKEN, offset +12
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
forward_1:
addi s0, s0, 1 # EXPECT: s0 = 0x00000002

# Taken BEQ with exactly +16 byte displacement.
beq x0, x0, forward_2 # offset +16 # EXPECT: TAKEN, offset +16
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
forward_2:
addi s0, s0, 1 # EXPECT: s0 = 0x00000003

# Taken BEQ with exactly +28 byte displacement.
beq x0, x0, forward_3 # offset +28 # EXPECT: TAKEN, offset +28
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
forward_3:
addi s0, s0, 1 # EXPECT: s0 = 0x00000004

# Taken BEQ with exactly +32 byte displacement.
beq x0, x0, forward_4 # offset +32 # EXPECT: TAKEN, offset +32
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
forward_4:
addi s0, s0, 1 # EXPECT: s0 = 0x00000005

# Taken BEQ with exactly +60 byte displacement.
beq x0, x0, forward_5 # offset +60 # EXPECT: TAKEN, offset +60
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
forward_5:
addi s0, s0, 1 # EXPECT: s0 = 0x00000006

# Taken BEQ with exactly +64 byte displacement.
beq x0, x0, forward_6 # offset +64 # EXPECT: TAKEN, offset +64
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
forward_6:
addi s0, s0, 1 # EXPECT: s0 = 0x00000007

# Taken BEQ with exactly +128 byte displacement.
beq x0, x0, forward_7 # offset +128 # EXPECT: TAKEN, offset +128
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
forward_7:
addi s0, s0, 1 # EXPECT: s0 = 0x00000008

# Taken BEQ with exactly +256 byte displacement.
beq x0, x0, forward_8 # offset +256 # EXPECT: TAKEN, offset +256
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
forward_8:
addi s0, s0, 1 # EXPECT: s0 = 0x00000009

# Taken BEQ with exactly +512 byte displacement.
beq x0, x0, forward_9 # offset +512 # EXPECT: TAKEN, offset +512
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
forward_9:
addi s0, s0, 1 # EXPECT: s0 = 0x0000000a

# Taken BEQ with exactly +1024 byte displacement.
beq x0, x0, forward_10 # offset +1024 # EXPECT: TAKEN, offset +1024
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
addi a0, a0, 1 # filler; correct execution skips this # EXPECT: SKIPPED on correct execution
forward_10:
addi s0, s0, 1 # EXPECT: s0 = 0x0000000b
addi t2, a0, 0 # expected 0; no skipped instructions may execute # EXPECT: t2 = 0x00000000

# Final checkpoints:
# s0 = 0x0000000b
# a0 = 0x00000000
