data = '''0 5 -1 -1
5 0 2 4
-1 2 0 1
-1 4 1 0'''

li = data.split('\n')

idx1 = 0
for num1 in li:
    idx2 = 1
    nums = num1.split(' ')
    for num2 in nums:
        print("addi $t0 $zero {}\nsw $t0 {}($zero)".format(num2, 32 * 4 *idx1 + 4 * idx2), end="\n")
        idx2 += 1
    idx1 += 1