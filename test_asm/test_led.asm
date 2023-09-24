li $a0 11
li $t9 4065

# led-a
beq $a0 1 aoff
beq $a0 4 aoff
beq $a0 11 aoff
beq $a0 12 aoff
beq $a0 13 aoff
j afinish
aoff:
sub $t9 $t9 32
afinish:

#led-b
beq $a0 5 boff
beq $a0 6 boff
beq $a0 11 boff
beq $a0 12 boff
beq $a0 14 boff
beq $a0 15 boff
j bfinish
boff:
sub $t9 $t9 64
bfinish:

#led-c
beq $a0 2 coff
beq $a0 12 coff
beq $a0 14 coff
beq $a0 15 coff
j cfinish
coff:
sub $t9 $t9 128
cfinish:

beq $a0 1 doff
beq $a0 4 doff
beq $a0 7 doff
beq $a0 10 doff
beq $a0 15 doff
j dfinish
doff:
sub $t9 $t9 256
dfinish:

beq $a0 1 eoff
beq $a0 3 eoff
beq $a0 4 eoff
beq $a0 5 eoff
beq $a0 7 eoff
beq $a0 9 eoff
j efinish
eoff:
sub $t9 $t9 512
efinish:

beq $a0 1 foff
beq $a0 2 foff
beq $a0 3 foff
beq $a0 7 foff
beq $a0 12 foff
beq $a0 13 foff
j ffinish
foff:
sub $t9 $t9 1024
ffinish:

beq $a0 0 goff
beq $a0 1 goff
beq $a0 7 goff
j gfinish
goff:
sub $t9 $t9 2048
gfinish:

sw $t9 0($t0)



