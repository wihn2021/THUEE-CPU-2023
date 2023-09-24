# test ALU
addi $s1, $zero, 50
addi $s1, $s1, 50
addi $s2, $zero, 200
add $s3, $s1, $s2
move $s4, $s3

# $s1 = 100 $s2 = 200 $s3 = 300

# test data memory
sw $s1, 8($zero)
nop
nop
nop
lw $s4, 8($zero)

# $s4 = 100

# test ALU forwarding
addi $t1, $zero, 3
addi $t2, $t1, 5
addi $t3, $zero, 3
addi $t3, $zero, 6
add $t4, $t3, -1

# $t2 = 8 $t4 = 5