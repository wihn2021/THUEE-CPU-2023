addi $s1, $zero, 0
addi $s2, $zero, 0
addi $s3, $zero, 0
j l2
l3:
addi $s1, $s1, 1
addi $s2, $s2, 1
jr $ra
addi $s3, $s3, 1
addi $s1, $s1, 2
l2:
addi $s2, $s2, 4
addi $s3, $s3, 4
jal l3
addi $s1, $s1, 8
addi $s2, $s2, 8
