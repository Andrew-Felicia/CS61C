# Task 6: x0 protection and full rs1/rs2 register-index decoding.
# Expected destination values after each instruction, in RV32 hexadecimal.
# Uses only Task 5 setup instructions and the Task 6 instructions named here.
# The course integration harness supplies pass/fail comparisons.

# Each operation would produce a nonzero result if x0 were writable.
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
add x0, t0, t1            # x0 = 0x00000000 (write ignored)
addi t2, x0, 0            # t2 = 0x00000000
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
sub x0, t0, t1            # x0 = 0x00000000 (write ignored)
addi t2, x0, 0            # t2 = 0x00000000
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
and x0, t0, t1            # x0 = 0x00000000 (write ignored)
addi t2, x0, 0            # t2 = 0x00000000
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
or x0, t0, t1             # x0 = 0x00000000 (write ignored)
addi t2, x0, 0            # t2 = 0x00000000
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
xor x0, t0, t1            # x0 = 0x00000000 (write ignored)
addi t2, x0, 0            # t2 = 0x00000000
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
sll x0, t0, t1            # x0 = 0x00000000 (write ignored)
addi t2, x0, 0            # t2 = 0x00000000
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
srl x0, t0, t1            # x0 = 0x00000000 (write ignored)
addi t2, x0, 0            # t2 = 0x00000000
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
sra x0, t0, t1            # x0 = 0x00000000 (write ignored)
addi t2, x0, 0            # t2 = 0x00000000
addi t0, x0, 1            # t0 = 0x00000001
addi t1, x0, 2            # t1 = 0x00000002
slt x0, t0, t1            # x0 = 0x00000000 (write ignored)
addi t2, x0, 0            # t2 = 0x00000000
addi t0, x0, -7           # t0 = 0xfffffff9
addi t1, x0, 3            # t1 = 0x00000003
mul x0, t0, t1            # x0 = 0x00000000 (write ignored)
addi t2, x0, 0            # t2 = 0x00000000
addi t0, x0, -1           # t0 = 0xffffffff
addi t1, x0, 2            # t1 = 0x00000002
mulh x0, t0, t1           # x0 = 0x00000000 (write ignored)
addi t2, x0, 0            # t2 = 0x00000000
addi t0, x0, -1           # t0 = 0xffffffff
addi t1, x0, 2            # t1 = 0x00000002
mulhu x0, t0, t1          # x0 = 0x00000000 (write ignored)
addi t2, x0, 0            # t2 = 0x00000000

# x0 as either source, for every operation.
addi t0, x0, -7           # t0 = 0xfffffff9
add t1, x0, t0            # t1 = 0xfffffff9
add t2, t0, x0            # t2 = 0xfffffff9
sub t1, x0, t0            # t1 = 0x00000007
sub t2, t0, x0            # t2 = 0xfffffff9
and t1, x0, t0            # t1 = 0x00000000
and t2, t0, x0            # t2 = 0x00000000
or t1, x0, t0             # t1 = 0xfffffff9
or t2, t0, x0             # t2 = 0xfffffff9
xor t1, x0, t0            # t1 = 0xfffffff9
xor t2, t0, x0            # t2 = 0xfffffff9
sll t1, x0, t0            # t1 = 0x00000000
sll t2, t0, x0            # t2 = 0xfffffff9
srl t1, x0, t0            # t1 = 0x00000000
srl t2, t0, x0            # t2 = 0xfffffff9
sra t1, x0, t0            # t1 = 0x00000000
sra t2, t0, x0            # t2 = 0xfffffff9
slt t1, x0, t0            # t1 = 0x00000000
slt t2, t0, x0            # t2 = 0x00000001
mul t1, x0, t0            # t1 = 0x00000000
mul t2, t0, x0            # t2 = 0x00000000
mulh t1, x0, t0           # t1 = 0x00000000
mulh t2, t0, x0           # t2 = 0x00000000
mulhu t1, x0, t0          # t1 = 0x00000000
mulhu t2, t0, x0          # t2 = 0x00000000

# Distinct high/low register indices on both ports; observable copies in t2.
addi x1, x0, 11           # x1 = 0x0000000b
addi x2, x0, 22           # x2 = 0x00000016
addi x4, x0, 44           # x4 = 0x0000002c
addi x8, x0, 88           # x8 = 0x00000058
addi x16, x0, 160         # x16 = 0x000000a0
addi x31, x0, 310         # x31 = 0x00000136
sub t2, x1, x31           # t2 = 0xfffffed5
sub t2, x31, x1           # t2 = 0x0000012b
sub t2, x2, x31           # t2 = 0xfffffee0
sub t2, x31, x2           # t2 = 0x00000120
sub t2, x4, x31           # t2 = 0xfffffef6
sub t2, x31, x4           # t2 = 0x0000010a
sub t2, x8, x31           # t2 = 0xffffff22
sub t2, x31, x8           # t2 = 0x000000de
sub t2, x16, x31          # t2 = 0xffffff6a
sub t2, x31, x16          # t2 = 0x00000096
sub t2, x31, x31          # t2 = 0x00000000
sub t2, x31, x31          # t2 = 0x00000000

# High-index destination followed by reads on both ports.
sub x30, x31, x16         # x30 = 0x00000096
addi t2, x30, 0           # t2 = 0x00000096
sub t2, x30, x1           # t2 = 0x0000008b
sub t2, x1, x30           # t2 = 0xffffff75
