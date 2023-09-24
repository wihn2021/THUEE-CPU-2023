addi $t0 $zero 4
sw $t0 0($zero)
addi $t0 $zero 0
sw $t0 4($zero)
addi $t0 $zero 5
sw $t0 8($zero)
addi $t0 $zero -1
sw $t0 12($zero)
addi $t0 $zero -1
sw $t0 16($zero)
addi $t0 $zero 5
sw $t0 20($zero)
addi $t0 $zero 0
sw $t0 24($zero)
addi $t0 $zero 2
sw $t0 28($zero)
addi $t0 $zero 4
sw $t0 32($zero)
addi $t0 $zero -1
sw $t0 36($zero)
addi $t0 $zero 2
sw $t0 40($zero)
addi $t0 $zero 0
sw $t0 44($zero)
addi $t0 $zero 1
sw $t0 48($zero)
addi $t0 $zero -1
sw $t0 52($zero)
addi $t0 $zero 4
sw $t0 56($zero)
addi $t0 $zero 1
sw $t0 60($zero)
addi $t0 $zero 0
sw $t0 64($zero)
move $t0 $zero

addi $t0 $zero 0
lw $a0 0($t0)
addi $a1 $t0 4
# a0 is n a1 is graph

addi $t0 $zero 200 # dist
sw $zero 0($t0)
addi $t1 $t0 4 # dist[1]
sll $a0 $a0 2 # 4n
add $t2 $a0 $t0
addi $t3 $zero -1
br1:
beq $t1 $t2 out1
sw $t3 0($t1)
addi $t1 $t1 4
j br1
out1:

# $s1 is i
# s2 is u
# s3 is v

addi $s1 $zero 4
br2:
beq $s1 $a0 out2

addi $s2 $zero 0
br3:
beq $s2 $a0 out3

addi $s3 $zero 0
br4:
beq $s3 $a0 out4
sll $t5 $s2 5
add $t5 $t5 $s3 # addr
add $t6 $t0 $s2 # dist[u]
lw $t7 0($t6) # dist[u]
beq $t7 -1 continue4
add $t6 $a1 $t5
lw $t8 0($t6) # graph[addr]
beq $t8 -1 continue4
add $s6 $t0 $s3
lw $t9 0($s6) # dist[v]
add $s4 $t7 $t8 # dist[u] + graph[addr]
beq $t9 -1 doss
sub $s5 $t9 $s4
bgtz doss
j continue4

doss:
sw $s4 0($s6)

continue4:
addi $s3 $s3 4
j br4
out4:

addi $s2 $s2 4
j br3
out3:

addi $s1 $s1 4
j br2
out2:

addi $t9 $zero 1