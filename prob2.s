.data
vetor: .word 1 5 0 0 1 4 2 4 6 8 2
.text
main:
la x12, vetor
addi x13, x0, 11
jal x1, verificacpf
beq x0, x0, FIM
##### START MODIFIQUE AQUI START #####

checa_resto: # Checa o resto da divisão dos valores obtidos conforme os algoritmos
blt x6, x19, menor_que_2 # Caso o resto, armazenado em x6, seja menor que 2, armazenado no registrador x19
bge x6, x19, maior_ou_igual_a_2 # Caso o resto, armazenado em x6, seja maior ou igual que 2, armazenado no registrador x19

menor_que_2: # Atribui os valores conforme o caso em que o resto seja menor que 2
add x8, x0, x0 # O valor na posição referente à chamada no registro deve ser 0
jalr x0, 0(x1) # Retorna a x1

maior_ou_igual_a_2: # Atribui os valores conforme o caso em que o resto seja maior ou igual a 2
neg x9, x6 # x9 recebe x6 negativado
addi x8, x9, 11 # O valor na posição referente à chamada no registro deve ser x9 + 11, vulgo 11 - x6 (resto da divisão) 
jalr x0, 0(x1) # Retorna a x1

cadastro_invalido: # Instrução que, caso o cadastro seja inválido, irá redirecionar para o final da execução com retorno 0
add x10, x0, x0 # Atribui o valor 0 ao registrador de retorno x10
jalr x0, 0(x1) # Retorna a x1

cadastro_valido: # Instrução que, caso o cadastro seja inválido, irá redirecionar para o final da execução com retorno 1
addi x10, x0, 1 # Atribui o valor 1 ao registrador de retorno x10
jalr x0, 0(x1) # Retorna a x1

soma_digitos_cpf: # Instrução que soma os dígitos do CPF conforme o algoritmo conhecido
lw x24, 0(x13) # Carrega em x24 o valor de x13, que representa a posição do vetor do cadastro que estamos no momento
mul x3, x24, x22 # Multiplica o valor naquela posição do vetor pelo valor atual conforme o algoritmo, armazenado em x22
add x5, x3, x5 # Adiciona o valor obtido no contador disponibilizado no registrador x5
addi x13, x13, -4 # Decrementa uma posição no ponteiro do vetor
addi x22, x22, 1 # Adiciona 1 à constante utilizada para os cálculos do algoritmo
bge x13, x12, soma_digitos_cpf # Se o ponteiro de varredura vetor for maior ou igual à posição inicial do mesmo, chama o procedimento novamente
jalr x0, 0(x1) # Retorna a x1

verificacpf: # Instrução que verifica o CPF
addi x11, x0, 11 # x11 recebe o valor da constante 11, útil para contas nos algoritmos de verificação de cadastro
addi x19, x0, 2 # x19 recebe o valor da constante 2, útil para contas nos algoritmos de verificação de cadastro
addi x13, x13, -1 # Essa e as próximas 2 linhas configuram x13 para ser a posição final do vetor, conforme seu tamanho
slli x13, x13, 2
add x13, x12, x13
addi sp, sp, -16 # Aloco dois espaços na pilha
sw x13, 8(sp) # Armazeno o valor de endereço do final do vetor na segunda posição da pilha
sw x1, 0(sp) # Armazeno o valor de x1 (caminho de instrução para finalizar a execução) no topo da pilha
addi x13, x13, -8 # x13 agora armazena o endereço da antepenúltima posição do vetor (importante para a verificação dos cadastros)
add x5, x0, x0 # x5 será um contador e será inicializado com 0
addi x22, x0, 2 # x22 será uma variável auxiliar para as contas de verificação e é inicializada com 2
jal x1, soma_digitos_cpf # Pulo para a instrução de soma de dígitos de CPF e linko x1 à próxima instrução
remu x6, x5, x11 # x6 recebe o resto deixado pela soma dos dígitos do CPF (armazenado em x5) na divisão por 11
jal x1, checa_resto # Pulo para a instrução de checagem de resto e linko x1 à próxima instrução
lw x1, 0(sp) # Armazeno em x1 o valor do topo da pilha, caminho de instrução para finalizar a execução armazenado anteriormente na memória
lw x20, 8(sp) # Armazeno em x20 o segundo valor na pilha, endereço do final do vetor de cadastro armazenado anteriormente
addi x20, x20, -4 # x20 recebe agora o endereço da penúltima posição do vetor de cadastro
lw x21, 0(x20) # x21 recebe o valor na penúltima posição do vetor de cadastro
bne x21, x8, cadastro_invalido # Se o valor calculado para o penúltimo valor do cadastro for diferente do valor passado, o cadastro é inválido
add x13, x0, x20 # x13 recebe agora o endereço da penúltima posição do vetor de cadastro
add x5, x0, x0 # x5 será um contador e será inicializado com 0
addi x22, x0, 2 # x22 será uma variável auxiliar para as contas de verificação e é inicializada com 2
jal x1, soma_digitos_cpf # Pulo para a instrução de soma de dígitos de CPF e linko x1 à próxima instrução
remu x6, x5, x11 # x6 recebe o resto deixado pela soma dos dígitos do CPF (armazenado em x5) na divisão por 11
jal x1, checa_resto # Pulo para a instrução de checagem de resto e linko x1 à próxima instrução
lw x1, 0(sp) # Armazeno em x1 o valor do topo da pilha, caminho de instrução para finalizar a execução armazenado anteriormente na memória
lw x20, 8(sp) # Armazeno em x20 o segundo valor na pilha, endereço do final do vetor de cadastro armazenado anteriormente
addi sp, sp, 16 # Desaloco duas posições na pilha
lw x21, 0(x20) # x21 recebe o valor na última posição do vetor de cadastro
bne x21, x8, cadastro_invalido # Se o valor calculado para o último valor do cadastro for diferente do valor passado, o cadastro é inválido
beq x0, x0, cadastro_valido # Se chegamos nessa intrução, nosso cadastro é válido e chamaos a instrução feita para esse caso

soma_digitos_cnpj:
lw x24, 0(x13) # Carrega em x24 o valor de x13, que representa a posição do vetor do cadastro que estamos no momento
add x25, x22, x0 # x25 recebe o valor armazenado em x22, para que esse valor seja resgatado posteriormente
# A aritmética feita nas próximas três linhas foi utilizada para o cálculo dos valores utilizados no algoritmo de verificação de CNPJ
addi x22, x22, -2 # Subtrai-se 2 do valor armazenado em x22
remu x22, x22, x29 # x22 recebe agora o resto de sua divisão por 8
addi x22, x22, 2 # Somamos 2 de volta ao valor no registrador x22
mul x3, x24, x22 # x3 receb o valor da multiplicação entre x24(valor na atual posição do vetor) e x22(atual constante calculada)
add x5, x3, x5 # O resultado obtido em x3 é somado à x5
addi x13, x13, -4 # Decrementa uma posição no ponteiro do vetor
add x22, x0, x25 # x22 recebe o valor armazenado em x25, seu valor original antes dos cálculos
addi x22, x22, 1 # Adiciona 1 à constante utilizada para os cálculos do algoritmo
bge x13, x12, soma_digitos_cnpj # Se o ponteiro de varredura vetor for maior ou igual à posição inicial do mesmo, chama o procedimento novamente
jalr x0, 0(x1) # Retorna a x1

verificacnpj:
addi x29, x0, 8 # x29 recebe a contante 8, valor útil para os cálculos de verificação de CNPJ
addi x13, x13, -1 # Essa e as próximas 2 linhas configuram x13 para ser a posição final do vetor, conforme seu tamanho
slli x13, x13, 2
add x13, x12, x13
addi sp, sp, -16 # Aloco dois espaços na pilha
sw x13, 8(sp) # Armazeno o valor de endereço do final do vetor na segunda posição da pilha
sw x1, 0(sp) # Armazeno o valor de x1 (caminho de instrução para finalizar a execução) no topo da pilha
addi x13, x13, -8 # x13 agora armazena o endereço da antepenúltima posição do vetor (importante para a verificação dos cadastros)
add x5, x0, x0 # x5 será um contador e será inicializado com 0
addi x22, x0, 2 # x22 recebe o valor da constante 2, útil para os cálculos posteriormente
jal x1, soma_digitos_cnpj # Pulo para a instrução de soma de dígitos de CNPJ e linko x1 à próxima instrução
addi x11, x0, 11 # x11 recebe o valor da constante 11
addi x19, x0, 2 # x19 recebe o valor da constante 2
remu x6, x5, x11 # x6 recebe o resto deixado pela soma dos dígitos do CPF (armazenado em x5) na divisão por 11
jal x1, checa_resto # Pulo para a instrução de checagem de resto e linko x1 à próxima instrução
lw x1, 0(sp) # Armazeno em x1 o valor do topo da pilha, caminho de instrução para finalizar a execução armazenado anteriormente na memória
lw x20, 8(sp) # Armazeno em x20 o segundo valor na pilha, endereço do final do vetor de cadastro armazenado anteriormente
addi x20, x20, -4 # x20 recebe agora o endereço da penúltima posição do vetor de cadastro
lw x21, 0(x20) # x21 recebe o valor na penúltima posição do vetor de cadastro
bne x21, x8, cadastro_invalido # Se o valor calculado para o penúltimo valor do cadastro for diferente do valor passado, o cadastro é inválido
add x13, x0, x20 # x13 recebe agora o endereço da penúltima posição do vetor de cadastro
add x5, x0, x0 # x5 será um contador e será inicializado com 0
addi x22, x0, 2 # x22 recebe o valor da constante 2, útil para os cálculos posteriormente
jal x1, soma_digitos_cnpj # Pulo para a instrução de soma de dígitos de CNPJ e linko x1 à próxima instrução
addi x11, x0, 11 # x11 recebe o valor da constante 11
addi x19, x0, 2 # x19 recebe o valor da constante 2
remu x6, x5, x11 # x6 recebe o resto deixado pela soma dos dígitos do CPF (armazenado em x5) na divisão por 11
jal x1, checa_resto # Pulo para a instrução de checagem de resto e linko x1 à próxima instrução
lw x1, 0(sp) # Armazeno em x1 o valor do topo da pilha, caminho de instrução para finalizar a execução armazenado anteriormente na memória
lw x20, 8(sp) # Armazeno em x20 o segundo valor na pilha, endereço do final do vetor de cadastro armazenado anteriormente
addi sp, sp, 16 # Desaloco duas posições na pilha
lw x21, 0(x20) # x21 recebe o valor na última posição do vetor de cadastro
bne x21, x8, cadastro_invalido # Se o valor calculado para o último valor do cadastro for diferente do valor passado, o cadastro é inválido
beq x0, x0, cadastro_valido # Se chegamos nessa intrução, nosso cadastro é válido e chamaos a instrução feita para esse caso

verificadastro: jalr x0, 0(x1)

##### END MODIFIQUE AQUI END #####
FIM: add x1, x0, x10
