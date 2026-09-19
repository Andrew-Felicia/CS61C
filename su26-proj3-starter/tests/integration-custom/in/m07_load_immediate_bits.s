# Task 8: I-type address offsets, including -2048/+2047; canonical store avoids paired address bugs.
# EXPECT comments describe state AFTER each instruction.
# No LUI, pseudoinstructions, data directives, or uninitialized memory reads.

addi t0, x0, 0             # EXPECT: t0 = 0x00000000
slli t0, t0, 11            # EXPECT: t0 = 0x00000000
addi t0, t0, 2             # EXPECT: t0 = 0x00000002
slli t0, t0, 11            # EXPECT: t0 = 0x00001000
addi t1, x0, 519           # EXPECT: t1 = 0x00000207
slli t1, t1, 11            # EXPECT: t1 = 0x00103800
addi t1, t1, 2000          # EXPECT: t1 = 0x00103fd0
slli t1, t1, 11            # EXPECT: t1 = 0x81fe8000
addi t1, t1, 127           # EXPECT: t1 = 0x81fe807f
sw t1, 0(t0)               # EXPECT: mem[0x1000..0x1003] = 0x81fe807f; registers unchanged

# Base 4096 + offset 0 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 2             # EXPECT: s0 = 0x00000002
slli s0, s0, 11            # EXPECT: s0 = 0x00001000
lb t2, 0(s0)               # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 0(s0)               # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 0(s0)               # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 4095 + offset 1 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 1             # EXPECT: s0 = 0x00000001
slli s0, s0, 11            # EXPECT: s0 = 0x00000800
addi s0, s0, 2047          # EXPECT: s0 = 0x00000fff
lb t2, 1(s0)               # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 1(s0)               # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 1(s0)               # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 4094 + offset 2 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 1             # EXPECT: s0 = 0x00000001
slli s0, s0, 11            # EXPECT: s0 = 0x00000800
addi s0, s0, 2046          # EXPECT: s0 = 0x00000ffe
lb t2, 2(s0)               # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 2(s0)               # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 2(s0)               # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 4092 + offset 4 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 1             # EXPECT: s0 = 0x00000001
slli s0, s0, 11            # EXPECT: s0 = 0x00000800
addi s0, s0, 2044          # EXPECT: s0 = 0x00000ffc
lb t2, 4(s0)               # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 4(s0)               # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 4(s0)               # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 4088 + offset 8 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 1             # EXPECT: s0 = 0x00000001
slli s0, s0, 11            # EXPECT: s0 = 0x00000800
addi s0, s0, 2040          # EXPECT: s0 = 0x00000ff8
lb t2, 8(s0)               # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 8(s0)               # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 8(s0)               # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 4080 + offset 16 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 1             # EXPECT: s0 = 0x00000001
slli s0, s0, 11            # EXPECT: s0 = 0x00000800
addi s0, s0, 2032          # EXPECT: s0 = 0x00000ff0
lb t2, 16(s0)              # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 16(s0)              # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 16(s0)              # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 4065 + offset 31 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 1             # EXPECT: s0 = 0x00000001
slli s0, s0, 11            # EXPECT: s0 = 0x00000800
addi s0, s0, 2017          # EXPECT: s0 = 0x00000fe1
lb t2, 31(s0)              # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 31(s0)              # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 31(s0)              # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 4064 + offset 32 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 1             # EXPECT: s0 = 0x00000001
slli s0, s0, 11            # EXPECT: s0 = 0x00000800
addi s0, s0, 2016          # EXPECT: s0 = 0x00000fe0
lb t2, 32(s0)              # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 32(s0)              # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 32(s0)              # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 4032 + offset 64 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 1             # EXPECT: s0 = 0x00000001
slli s0, s0, 11            # EXPECT: s0 = 0x00000800
addi s0, s0, 1984          # EXPECT: s0 = 0x00000fc0
lb t2, 64(s0)              # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 64(s0)              # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 64(s0)              # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 3968 + offset 128 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 1             # EXPECT: s0 = 0x00000001
slli s0, s0, 11            # EXPECT: s0 = 0x00000800
addi s0, s0, 1920          # EXPECT: s0 = 0x00000f80
lb t2, 128(s0)             # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 128(s0)             # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 128(s0)             # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 3840 + offset 256 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 1             # EXPECT: s0 = 0x00000001
slli s0, s0, 11            # EXPECT: s0 = 0x00000800
addi s0, s0, 1792          # EXPECT: s0 = 0x00000f00
lb t2, 256(s0)             # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 256(s0)             # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 256(s0)             # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 3584 + offset 512 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 1             # EXPECT: s0 = 0x00000001
slli s0, s0, 11            # EXPECT: s0 = 0x00000800
addi s0, s0, 1536          # EXPECT: s0 = 0x00000e00
lb t2, 512(s0)             # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 512(s0)             # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 512(s0)             # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 3072 + offset 1024 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 1             # EXPECT: s0 = 0x00000001
slli s0, s0, 11            # EXPECT: s0 = 0x00000800
addi s0, s0, 1024          # EXPECT: s0 = 0x00000c00
lb t2, 1024(s0)            # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 1024(s0)            # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 1024(s0)            # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 2049 + offset 2047 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 1             # EXPECT: s0 = 0x00000001
slli s0, s0, 11            # EXPECT: s0 = 0x00000800
addi s0, s0, 1             # EXPECT: s0 = 0x00000801
lb t2, 2047(s0)            # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, 2047(s0)            # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, 2047(s0)            # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 4097 + offset -1 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 2             # EXPECT: s0 = 0x00000002
slli s0, s0, 11            # EXPECT: s0 = 0x00001000
addi s0, s0, 1             # EXPECT: s0 = 0x00001001
lb t2, -1(s0)              # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, -1(s0)              # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, -1(s0)              # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 4098 + offset -2 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 2             # EXPECT: s0 = 0x00000002
slli s0, s0, 11            # EXPECT: s0 = 0x00001000
addi s0, s0, 2             # EXPECT: s0 = 0x00001002
lb t2, -2(s0)              # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, -2(s0)              # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, -2(s0)              # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 4112 + offset -16 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 2             # EXPECT: s0 = 0x00000002
slli s0, s0, 11            # EXPECT: s0 = 0x00001000
addi s0, s0, 16            # EXPECT: s0 = 0x00001010
lb t2, -16(s0)             # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, -16(s0)             # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, -16(s0)             # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 4128 + offset -32 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 2             # EXPECT: s0 = 0x00000002
slli s0, s0, 11            # EXPECT: s0 = 0x00001000
addi s0, s0, 32            # EXPECT: s0 = 0x00001020
lb t2, -32(s0)             # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, -32(s0)             # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, -32(s0)             # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 5120 + offset -1024 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 2             # EXPECT: s0 = 0x00000002
slli s0, s0, 11            # EXPECT: s0 = 0x00001000
addi s0, s0, 1024          # EXPECT: s0 = 0x00001400
lb t2, -1024(s0)           # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, -1024(s0)           # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, -1024(s0)           # EXPECT: a1 = 0x81fe807f from mem[0x1000]

# Base 6144 + offset -2048 = address 4096.
addi s0, x0, 0             # EXPECT: s0 = 0x00000000
slli s0, s0, 11            # EXPECT: s0 = 0x00000000
addi s0, s0, 3             # EXPECT: s0 = 0x00000003
slli s0, s0, 11            # EXPECT: s0 = 0x00001800
lb t2, -2048(s0)           # EXPECT: t2 = 0x0000007f from mem[0x1000]
lh a0, -2048(s0)           # EXPECT: a0 = 0xffff807f from mem[0x1000]
lw a1, -2048(s0)           # EXPECT: a1 = 0x81fe807f from mem[0x1000]
