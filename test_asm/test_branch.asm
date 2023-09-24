
addi $s4 $zero 1
addi $t9 $zero -1
nop
beq $t9 -1 doss
sub $s5 $t9 $s4
nop
bgtz $s5 doss
j continue4
doss:
addi $s1 $zero 2
continue4:
addi $s1 $zero 1
bgtz $s5 l2
addi $s1 $zero 2
l2:
addi $s1 $zero 3
bgtz $t9 l3
addi $s1 $zero 4
l3:
addi $s1 $zero 5
