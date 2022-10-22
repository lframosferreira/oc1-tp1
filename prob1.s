.data
vetor: .word 1 2 3 4 5 6 7
.text
main:
la x12, vetor
addi x13, x0, 7
addi x13, x13, -1
slli x13, x13, 2
add x13, x13, x12
jal x1, inverte
beq x0, x0, FIM
##### START MODIFIQUE AQUI START #####
#### A recursão será feita de dentro pra fora, ou seja, a chamada recursiva ####
#### mais interior irá reverter os elementos do meio do vetor ####
inverte:
addi sp, sp, -12 # Armazenamos os valores de x12, x13 e x1 na pilha
sw x1, 0(sp)
sw x12, 8(sp)
sw x13 4(sp)
bge x13, x12, l1 # se a posição final for maior ou igual que a inicial, continuamos o procedimento
addi sp, sp, 12 # Desalocamos os valores inválidos que armazenamos na pilha
jalr x0, 0(x1) # Retornamos à x1
l1:
addi x13, x13, -4 # "encurtamos" o vetor, considerando que ele termina na posição anterior à posição final prévia
addi x12, x12, 4 # "encurtamos" o vetor, considerando que ele começa na posição subsequente à posição inicial prévia
jal x1, inverte # Linkamos a próxima instrução à x1 e chamaos "inverte"
lw x1, 0(sp) # Recuperamos os valores de x12, x13 e x1 que estão no topo da pilha
lw x13, 4(sp)
lw x12, 8(sp)
addi sp, sp, 12 # Desalocamos as três primeiras posições da pilha
lw x9, 0(x12) # x9 recebe valor na posição inicial do vetor
lw x11, 0(x13) # x10 recebe o valor na posição final do vetor
sw x9, 0(x13) # a posição final do vetor recebe o valor de x9, que guarda o valor da posição inicial do vetor
sw x11, 0(x12) # a posição inicial do vetor receb o valor de x10, que guarda o valor da posição final do vetor
jalr x0, 0(x1) # retornamos à instrução na posição guardada em x1

##### END MODIFIQUE AQUI END #####
FIM: add x1, x0, x10
