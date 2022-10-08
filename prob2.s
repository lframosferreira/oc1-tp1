.data
vetor: .word 8 6 8 6 4 8 4 0 0 0 0 1 1 8 # 86.864.840/0001-18
.text
main:
la x12, vetor
addi x13, x0, 14
jal x1, verificacnpj
beq x0, x0, FIM
##### START MODIFIQUE AQUI START #####

cadastro_invalido:
add x10, x0, x0
jalr x0, 0(x1)

cadastro_valido:
addi x10, x0, 1
jalr x0, 0(x1)

soma_digitos_cpf:
lw x24, 0(x13)
mul x3, x24, x22
add x5, x3, x5
addi x13, x13, -4
addi x22, x22, 1
bge x13, x12, soma_digitos_cpf
jalr x0, 0(x1)

checa_resto:
blt x6, x19, menor_que_2
bge x6, x19, maior_ou_igual_a_2

menor_que_2:
add x8, x0, x0 # penultimo valor igual a 0
jalr x0, 0(x1)

maior_ou_igual_a_2:
neg x9, x6 # negativa x6
addi x8, x9, 11 # x8 recebe 11 - x6, penultimo valor 
jalr x0, 0(x1)

verificacpf:
addi x13, x13, -1
slli x13, x13, 2
add x13, x12, x13
addi sp, sp, -8
sw x13, 0(sp)
addi x13, x13, -8
add x5, x0, x0 # x5  = 0
addi x22, x0, 2 # x22 = 2
addi sp, sp, -8
sw x1, 0(sp)
jal x1, soma_digitos_cpf
addi x11, x0, 11 # X11 tem valor 11
addi x19, x0, 2 # x12 tem valor 2
remu x6, x5, x11 # x6 é x5mod11
jal x1, checa_resto
lw x20, 8(sp)
addi x20, x20, -4
lw x21, 0(x20)
bne x21, x8, cadastro_invalido
add x13, x0, x20
add x5, x0, x0 # x5  = 0
addi x22, x0, 2 # x22 = 2
jal x1, soma_digitos_cpf
addi x11, x0, 11 # X11 tem valor 11
addi x19, x0, 2 # x12 tem valor 2
remu x6, x5, x11 # x6 é x5mod11
jal x1, checa_resto
lw x1, 0(sp)
lw x20, 8(sp)
addi sp, sp, 16
lw x21, 0(x20)
bne x21, x8, cadastro_invalido
beq x0, x0, cadastro_valido

soma_digitos_cnpj:
lw x24, 0(x13)
add x25, x22, x0
addi x22, x22, -2
remu x22, x22, x29
addi x22, x22, 2
mul x3, x24, x22
add x5, x3, x5
addi x13, x13, -4
add x22, x0, x25
addi x22, x22, 1
bge x13, x12, soma_digitos_cnpj
jalr x0, 0(x1)

verificacnpj:
addi x29, x0, 8
addi x13, x13, -1
slli x13, x13, 2
add x13, x12, x13
addi sp, sp, -8
sw x13, 0(sp)
addi x13, x13, -8
add x5, x0, x0 # x5  = 0
addi x22, x0, 0 # x22 = 0
addi sp, sp, -8
sw x1, 0(sp)
jal x1, soma_digitos_cnpj
addi x11, x0, 11 # x11 tem valor 11
addi x19, x0, 2 # x12 tem valor 2
remu x6, x5, x11 # x6 é x5mod11
jal x1, checa_resto
lw x20, 8(sp)
addi x20, x20, -4
lw x21, 0(x20)
bne x21, x8, cadastro_invalido
add x13, x0, x20
add x5, x0, x0 # x5  = 0
addi x22, x0, 2 # x22 = 2
jal x1, soma_digitos_cnpj
addi x11, x0, 11 # X11 tem valor 11
addi x19, x0, 2 # x12 tem valor 2
remu x6, x5, x11 # x6 é x5mod11
jal x1, checa_resto
lw x1, 0(sp)
lw x20, 8(sp)
addi sp, sp, 16
lw x21, 0(x20)
bne x21, x8, cadastro_invalido
beq x0, x0, cadastro_valido
verificadastro: jalr x0, 0(x1)
##### END MODIFIQUE AQUI END #####
FIM: add x1, x0, x10
verificadastro: jalr x0, 0(x1)
##### END MODIFIQUE AQUI END #####
FIM: add x1, x0, x10
