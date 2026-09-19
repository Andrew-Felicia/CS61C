# Task 6: funct7 distinctions, I/R BSel transitions, and dependencies.
# Expected destination values after each instruction, in RV32 hexadecimal.
# Uses only Task 5 setup instructions and the Task 6 instructions named here.
# The course integration harness supplies pass/fail comparisons.

# ADD, SUB, MUL share funct3; SLL and MULH share funct3.
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
add t2, t0, t1            # t2 = 0xfffffffc
sub t2, t0, t1            # t2 = 0xfffffff6
mul t2, t0, t1            # t2 = 0xffffffeb
add t2, t0, t1            # t2 = 0xfffffffc
sll t2, t0, t1            # t2 = 0xffffffc8
mulh t2, t0, t1           # t2 = 0xffffffff
sll t2, t0, t1            # t2 = 0xffffffc8
srl t2, t0, t1            # t2 = 0x1fffffff
sra t2, t0, t1            # t2 = 0xffffffff
srl t2, t0, t1            # t2 = 0x1fffffff
mulhu t2, t0, t1          # t2 = 0x00000002
slt t2, t0, t1            # t2 = 0x00000001

# Switch between register and immediate forms with deliberately different operands.
add s0, t0, t1            # s0 = 0xfffffffc
addi s1, t0, 17           # s1 = 0x0000000a
add t2, t0, t1            # t2 = 0xfffffffc
and s0, t0, t1            # s0 = 0x00000001
andi s1, t0, 85           # s1 = 0x00000051
and t2, t0, t1            # t2 = 0x00000001
or s0, t0, t1             # s0 = 0xfffffffb
ori s1, t0, 85            # s1 = 0xfffffffd
or t2, t0, t1             # t2 = 0xfffffffb
xor s0, t0, t1            # s0 = 0xfffffffa
xori s1, t0, 85           # s1 = 0xffffffac
xor t2, t0, t1            # t2 = 0xfffffffa
sll s0, t0, t1            # s0 = 0xffffffc8
slli s1, t0, 1            # s1 = 0xfffffff2
sll t2, t0, t1            # t2 = 0xffffffc8
srl s0, t0, t1            # s0 = 0x1fffffff
srli s1, t0, 1            # s1 = 0x7ffffffc
srl t2, t0, t1            # t2 = 0x1fffffff
sra s0, t0, t1            # s0 = 0xffffffff
srai s1, t0, 1            # s1 = 0xfffffffc
sra t2, t0, t1            # t2 = 0xffffffff

# Back-to-back writes consumed through alternating read ports.
addi t0, x0, 7            # t0 = 0x00000007
addi t1, x0, 3            # t1 = 0x00000003
add t2, t0, t1            # t2 = 0x0000000a
sub s0, t2, t1            # s0 = 0x00000007
mul s1, t1, s0            # s1 = 0x00000015
xor t2, s1, t2            # t2 = 0x0000001f
sll s0, t2, t1            # s0 = 0x000000f8
sra s1, s0, t1            # s1 = 0x0000001f
slt t2, t1, s1            # t2 = 0x00000001
