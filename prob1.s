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
lw x9, 0(x12) # x9 recebe valor na posição inicial do vetor
lw x11, 0(x13) # x10 recebe o valor na posição final do vetor
sw x9, 0(x13) # a posição final do vetor recebe o valor de x9, que guarda o valor da posição inicial do vetor
sw x11, 0(x12) # a posição inicial do vetor receb o valor de x10, que guarda o valor da posição final do vetor
addi x13, x13, -4 # "encurtamos" o vetor, considerando que ele termina na posição anterior à posição final prévia
addi x12, x12, 4 # "encurtamos" o vetor, considerando que ele começa na posição subsequente à posição inicial prévia
bge x13, x12, inverte # se a posição final for maior ou igual que a inicial, continuamos o procedimento
jalr x0, 0(x1) # retornamos à instrução na posição guardada em x1
##### END MODIFIQUE AQUI END #####
FIM: add x1, x0, x10
