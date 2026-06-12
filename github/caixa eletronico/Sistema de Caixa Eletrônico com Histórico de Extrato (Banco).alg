algoritmo "Sistema de Caixa Eletrônico com Histórico de Extrato (Banco)"
// =========================================================================
// Nome do Projeto: Sistema de Caixa Eletrônico com Histórico de Extrato
// Descrição: Algoritmo para simulação de operações bancárias. Permite o
//            controle de saldo, saques (com validação de cédulas), depósitos
//            e armazenamento de histórico de transações (extrato) em tempo real.
// Autor: Weriton Calazans de Moraes
// Data de Criação: 07/06/2026
// Versão: 1.0.0
// Ambiente: VisuAlg 3.0
// =========================================================================
var
   // --- VETORES PARALELOS PARA ARMAZENAMENTO DOS USUÁRIOS (Até 5 clientes) ---
   nome: vetor [1..5] de caractere
   conta: vetor [1..5] de caractere
   senha: vetor [1..5] de caractere
   saldo: vetor [1..5] de real
   
   // --- MATRIZES PARA HISTÓRICO ISOLADO POR USUÁRIO (Linha = Usuário, Coluna = Operação) ---
   nomeRecebido: vetor [1..5, 1..5] de caractere
   saque: vetor [1..5, 1..5] de caractere
   extratoSaida:vetor [1..5, 1..5] de real
   extratoDeposito: vetor [1..5, 1..5] de real
   
   // --- VARIÁVEIS GLOBAIS DE CONTROLE E ENTRADA ---
   agencia: caractere
   cadastro: caractere
   cadastroSenha: caractere
   sair: caractere
   opcao: inteiro
   conta_gerada:inteiro
   eu: caractere
   entrada_usuario: caractere
   entrada_agencia: caractere
   entrada_conta: caractere
   entrada_senha: caractere
   transferencia: caractere
   deposito: caractere
   aux: real               // Variável auxiliar para conversões numéricas
   posicao: inteiro        // Guarda o índice do usuário logado no sistema
   posicaoReceber:inteiro  // Guarda o índice do usuário que vai receber o PIX
   i, j, k:inteiro         // Contadores de estruturas de repetição (loops)
   continuar, encontrado, erro: logico // Flags (sinalizadores) booleanos de fluxo

// =========================================================================
// PROCEDIMENTO: menuInicial
// Objetivo: Renderizar na tela as opções internas da conta do cliente logado
// =========================================================================
procedimento menuInicial()
inicio
   escreval ("-----------------------------------------")
   escreval ("              Menu Inicial               ")
   escreval ("-----------------------------------------")
   escreval ("   Digite [1] Para ver saldo.   ")
   escreval ("   Digite [2] Para fazer depósito  ")
   escreval ("   Digite [3] Para fazer uma transferência via pix.  ")
   escreval ("   Digite [4] para extrato de saída. ")
   escreval ("   Digite [5] para extrato de depósito. ")
   escreval ("   Digite [6] para fazer saque.  ")
   escreval ("   Digite [7] Para sair.  ")
   leia(opcao)
fimprocedimento

// =========================================================================
// PROCEDIMENTO: opcaoEntrada
// Objetivo: Menu inicial exibido após o fluxo de cadastros do sistema
// =========================================================================
procedimento opcaoEntrada()
inicio
   escreval ("    [1] Para acessar sua conta. ")
   escreval ("    [2] Para sair  ")
   leia(entrada_usuario)
fimprocedimento

// =========================================================================
// PROCEDIMENTO: validaSim
// Objetivo: Validar entradas textuais de confirmação (SIM/NÃO), tratando erros
// =========================================================================
procedimento  validaSim(var a:caractere)
inicio
   a <- maiusc(a) // Padroniza a resposta para caixa alta
   se (a = "SIM") entao
      limpatela
   fimse

   // Se o usuário desistir, o programa fecha imediatamente com segurança
   se (a = "NAO") ou (a = "NÃO") entao
      escreval ("    Encerrando o programa com segurança  ")
      fimalgoritmo
   fimse

   // Loop de insistência caso o usuário digite algo diferente de SIM ou NÃO
   se (a <> "SIM") e (a <> "NAO") e (a <> "NÃO") entao
      repita
         escreval ("    Erro! digite apenas [ SIM/NÃO ] para tentar novamente. ")
         leia (a)
         a <- maiusc(a)

         se (a = "NÃO") ou (a = "NAO") entao
            escreval ("    Encerrando o programa com segurança  ")
            fimalgoritmo
         fimse
      ate (a = "SIM")
   fimse
fimprocedimento

// =========================================================================
// FUNÇÃO: validaLetras
// Objetivo: Retornar FALSO se a string contiver números ou símbolos proibidos
// =========================================================================
funcao validaLetras(texto: caractere) : logico
var
   proibidos: caractere
   i: inteiro
   valido: logico
inicio
   valido <- verdadeiro
   proibidos <- "0123456789!@#$%¨&*()_+-=[]{}?/;,.:>_<|`´"

   // Varre caractere por caractere do texto procurando correspondência na lista de proibidos
   para i <- 1 ate compr(proibidos) faca
      se pos(copia(proibidos, i, 1), texto) > 0 entao
         valido <- falso // Se achou um caractere proibido, invalida o nome
         interrompa
      fimse
   fimpara

   retorne valido
fimfuncao

// =========================================================================
// FUNÇÃO: validaNumero
// Objetivo: Validar via tabela ASCII se a string contém apenas dígitos numéricos
// =========================================================================
funcao validaNumero (numero: caractere) : logico
var
   valido: logico
   i, contador, codigo: inteiro
inicio
   contador <- 0
   valido <- verdadeiro
   
   // Varre cada caractere da string enviada
   para i <- 1 ate compr(numero) faca
      codigo <- asc(copia(numero, i, 1)) // Pega o código ASCII do caractere
      
      // Se o código não estiver entre 48 (zero) e 57 (nove), não é número
      se (codigo < 48) ou (codigo > 57) entao
         valido <- falso
      fimse
      
      // Controla o uso de pontos ou vírgulas decimais (máximo 1 permitido)
      se (codigo = 44) ou (codigo = 46) entao
         contador <- contador + 1
      fimse
   fimpara
      se (contador >= 2) entao
         valido <- falso
      fimse
   
   retorne valido
fimfuncao

// =========================================================================
// PROCEDIMENTO: organizarVetor
// Objetivo: Ordenar os usuários em ordem alfabética (Algoritmo Insertion Sort)
// Sincroniza todos os vetores e matrizes associadas à posição do usuário
// =========================================================================
procedimento organizarVetor()
var
   // Variáveis temporárias para armazenar a "chave" durante a ordenação
   chave_nome: caractere
   chave_conta: caractere
   chave_senha: caractere
   chave_saldo: real
   chave_saque: vetor [1..5] de caractere
   chave_extratoSaida: vetor [1..5] de real
   chave_extratoDeposito: vetor [1..5] de real
   chave_nomeRecebido: vetor [1..5] de caractere
   i, j, k: inteiro
inicio
   para i <- 2 ate 5 faca
      se (nome[i] <> "") entao
         // Passo 1: Captura a chave atual do elemento que será movido
         chave_nome <- nome[i]
         chave_conta <- conta[i]
         chave_senha <- senha[i]
         chave_saldo <- saldo[i]
         para k <- 1 ate 5 faca
            chave_extratoSaida[k] <- extratoSaida[i, k]
            chave_extratoDeposito[k] <- extratoDeposito[i, k]
            chave_saque[k] <- saque[i, k]
            chave_nomeRecebido[k] <- nomeRecebido[i, k]
         fimpara
         
         // Passo 2: Abre espaço nos vetores empurrando registros maiores para a direita
         j <- (i - 1)
         enquanto (j > 0) faca
            se (nome[j] > chave_nome) e (nome[j] <> "") entao
               nome[j + 1] <- nome[j]
               conta[j + 1] <- conta[j]
               senha[j + 1] <- senha[j]
               saldo[j + 1] <- saldo[j]
               para k <- 1 ate 5 faca
                  nomeRecebido[j + 1, k] <- nomeRecebido[j, k]
                  extratoSaida[j + 1, k] <- extratoSaida[j, k]
                  extratoDeposito[j + 1, k] <- extratoDeposito[j, k]
                  saque[j + 1, k] <- saque[j, k]
               fimpara
               
               j <- (j - 1)
            senao
               interrompa
            fimse
         fimenquanto

         // Passo 3: Insere a chave armazenada na sua posição ordenada correta
         nome[j + 1] <- chave_nome
         conta[j + 1] <- chave_conta
         senha[j + 1] <- chave_senha
         saldo[j + 1] <- chave_saldo
         para k <- 1 ate 5 faca
            nomeRecebido[j + 1, k] <- chave_nomeRecebido[k]
            extratoSaida[j + 1, k] <- chave_extratoSaida[k]
            extratoDeposito[j + 1, k] <- chave_extratoDeposito[k]
            saque[j + 1, k] <- chave_saque[k]
         fimpara
      fimse
   fimpara
fimprocedimento

// =========================================================================
// PROCEDIMENTO: inverte
// Objetivo: Inverter a ordem dos registros das matrizes de extrato.
// Permite mudar a visualização: de "mais antigo primeiro" para "mais recente"
// =========================================================================
procedimento inverte()
var
   aux4: caractere
   aux3: real
   aux2: caractere
   aux: real
   esq, dir, i: inteiro
inicio

   // Aplica a técnica dos dois ponteiros (esquerda e direita) trocando os extremos
   para i <- 1 ate 5 faca
       esq <- 1
       dir <- 5
       enquanto (esq < dir) faca
          // Inverte matriz extratoSaida
          aux <- extratoSaida[i, esq]
          extratoSaida[i, esq] <- extratoSaida[i, dir]
          extratoSaida[i, dir] <- aux

          // Inverte matriz nomeRecebido
          aux2 <- nomeRecebido[i, esq]
          nomeRecebido[i, esq] <- nomeRecebido[i, dir]
          nomeRecebido[i, dir] <- aux2

          // Inverte matriz extratoDeposito
          aux3 <- extratoDeposito[i, esq]
          extratoDeposito[i, esq] <- extratoDeposito[i, dir]
          extratoDeposito[i, dir] <- aux3

          // Inverte matriz saque
          aux4 <- saque[i, esq]
          saque[i, esq] <- saque[i, dir]
          saque[i, dir] <- aux4

          esq <- esq + 1
          dir <- dir - 1
       fimenquanto
    fimpara

fimprocedimento

// =========================================================================
// NÚCLEO PRINCIPAL DO SISTEMA
// =========================================================================
inicio
   agencia <- "0001"
   conta_gerada <- 12344 // Base para autoincremento de contas

   // Inicializa todas as contas com saldo zerado
   para i <- 1 ate 5 faca
      saldo[i] <- 0
   fimpara

   continuar <- verdadeiro
   // ----------------------------------------------------------------------
   // LOOP 1: Bloco de Cadastros do Banco (Gerencia o loop de novas contas)
   // ----------------------------------------------------------------------
   enquanto (continuar = verdadeiro) faca
      repita
         continuar <- falso
         repita
            limpatela
            escreval ("--------------------------------------")
            escreval ("    Bem-vindo à área de cadastro     ")
            escreval ("--------------------------------------")
            escreval ("    Digite seu nome!  ")
            leia (cadastro)
            
            // Valida se o nome possui apenas letras e não está vazio
            se (validaLetras(cadastro)) e (cadastro <> "") entao
               limpatela
               escreval ("----------------------------------------------------------")
               escreval ("    Nome '",cadastro,"' cadastrado com sucesso.  ")
               escreval ("----------------------------------------------------------")

               // Aloca o usuário na primeira posição vaga do vetor
               para i <- 1 ate 5 faca
                  se (nome[i] = "") entao
                     nome[i] <- cadastro
                     conta_gerada <- conta_gerada + 1 // Incrementa o número da conta
                     conta[i] <-numpcarac(conta_gerada) // Atribui o número gerado ao cliente
                     interrompa
                  fimse
               fimpara
               continuar <- verdadeiro
            senao
               escreval ("    Erro! Nome inválido. Digite apenas letras. ")
               escreval ("")
               escreval ("    Gostaria de tentar novamente? [ SIM/NÃO ] ")
               leia(sair)
               sair <- maiusc(sair)

               validaSim(sair)
            fimse
         ate (continuar = verdadeiro)

         // --- Sub-bloco: Cadastro de Senha ---
         continuar <- falso
         repita
            escreval ("--------------------------------------------")
            escreval ("    Cadastre sua senha com apenas 4 números  ")
            leia(cadastroSenha)

            // Garante que a senha possui apenas números e tem o tamanho exato de 4 dígitos
            se (validaNumero(cadastroSenha)) e (compr(cadastroSenha) = 4) e (cadastroSenha <> "") entao
               escreval ("    Senha cadastrada com sucesso.   ")
               para i <- 1 ate 5 faca
                  se (senha[i] = "") entao
                     senha[i] <- cadastroSenha
                     interrompa
                  fimse
               fimpara
               continuar <- verdadeiro

            senao
               escreval ("------------------------------------------")
               escreval ("             Senha inválida!              ")
               escreval ("    Deseja tentar novamente [ SIM/NÃO ]   ")
               escreval ("------------------------------------------")
               leia (sair)
               sair <- maiusc(sair)

               validaSim(sair)
            fimse
         ate (continuar = verdadeiro)

         // Exibe o comprovante dos dados cadastrados em tela
         para i <- 1 ate 5 faca
            se (nome[i] = cadastro) entao
               limpatela
               escreval ("Cadastro efetuado com sucesso. ")
               escreval ("-----------------------------------------")
               escreval ("Agência: ",agencia)
               escreval ("Conta: ",conta[i])
               escreval ("Usuário: ",nome[i])
               escreval ("Senha: ",senha[i])
               escreval ("-----------------------------------------")
               escreval ("Salve seus dados para acessar sua conta. ")
               escreval ("-----------------------------------------")
            fimse
         fimpara
         
         organizarVetor() // Ordena a base alfabeticamente para busca binária/sincronismo futuro
         
         escreval ("  Para fazer novo cadastro digite [ SIM/NÃO ] ")
         leia(sair)
         sair <- maiusc(sair)

         se (sair = "SIM") entao
            limpatela
            fimse

            // Fluxo executado caso o usuário encerre os cadastros e queira ir para o Login
            se (sair = "NAO") ou (sair = "NÃO") entao
               opcaoEntrada()

               se (entrada_usuario = "2") entao
                  escreval ("    Encerrando o programa com segurança  ")
                  fimalgoritmo
               fimse

               repita
                  se (entrada_usuario <> "1") e (entrada_usuario <> "2") entao
                     escreval ("   Digite apenas [ 1/2 ] ")
                     leia (entrada_usuario)

                     se (entrada_usuario = "2") entao
                        escreval ("    Encerrando o programa com segurança  ")
                        fimalgoritmo
                     fimse
                  fimse
               ate (entrada_usuario = "1")
            fimse

            // Proteção contra entradas espúrias no menu de novo cadastro
            se (sair <> "NÃO") e (sair <> "NAO") e (sair <> "SIM")entao
            repita
               escreval ("    Erro! Digite apenas [ SIM/NÃO ] para fazer novo cadastro.  ")
               leia (sair)
               sair <- maiusc(sair)

               se (sair = "NÃO") ou (sair = "NAO") entao
                  opcaoEntrada()

                  se (entrada_usuario = "1") entao
                     sair <- "SIM"
                  fimse

                  se (entrada_usuario = "2") entao
                     escreval ("    Encerrando o programa com segurança  ")
                     fimalgoritmo
                  fimse

                  repita
                     se (entrada_usuario <> "1") e (entrada_usuario <> "2") entao
                        escreval ("   Digite apenas [ 1/2 ] ")
                        leia (entrada_usuario)

                        se (entrada_usuario = "1") entao
                           sair <- "SIM"
                        fimse

                        se (entrada_usuario = "2") entao
                           escreval ("    Encerrando o programa com segurança  ")
                           fimalgoritmo
                        fimse
                     fimse
                  ate (entrada_usuario = "1")
               fimse
            ate (sair = "SIM")
         fimse

      ate (sair = "NAO")
      
      // ----------------------------------------------------------------------
      // LOOP 2: Bloco de Autenticação / Login do Usuário
      // ----------------------------------------------------------------------
      erro <- verdadeiro
      enquanto (erro = verdadeiro)  faca
         enquanto (entrada_usuario = "1") faca
            repita
               limpatela
               escreval ("-------------------------------")
               escreval ("    Digite o nome do usuário   ")
               leia(entrada_usuario)
               escreval ("-------------------------------")
               escreval ("    Digite sua agência    ")
               leia(entrada_agencia)
               escreval ("-------------------------------")
               escreval ("    Digite sua conta    ")
               leia(entrada_conta)
               escreval ("-------------------------------")
               escreval ("    Digite sua senha   ")
               leia(entrada_senha)

               entrada_usuario <- maiusc(entrada_usuario)
               encontrado <- falso

               // Varre a base de dados testando se todos os campos batem com o mesmo índice 'i'
               se (entrada_agencia = agencia) entao
                  para i <- 1 ate 5 faca
                     se (entrada_usuario = maiusc(nome[i])) e (entrada_conta = conta[i]) e (entrada_senha = senha[i]) entao
                        encontrado <- verdadeiro
                        posicao <- i // Captura o ID lógico (índice) do cliente autenticado
                        interrompa
                     fimse
                  fimpara
               fimse

               // Se logou com sucesso, chama o menu operacional interno
               se (encontrado = verdadeiro) entao
                  limpatela
                  escreval ("-----------------------------------------")
                  escreval ("    Bem-Vindo ",nome[posicao])
                  escreval ("-----------------------------------------")
                  menuInicial()
                  sair <- "NÃO"
               senao
                  escreval ("    ERRO! Usuário não encontrado   ")
                  escreval ("    Gostaria de tentar novamente [ SIM/NÃO ] ")
                  leia (sair)

                  validaSim(sair)
               fimse
            ate ((sair = "NAO") ou (sair = "NÃO"))
            
            // ----------------------------------------------------------------------
            // LOOP 3: Sistema de Escolha das Operações Bancárias (Menu Interno)
            // ----------------------------------------------------------------------
            repita
            repita
               escolha opcao
                  // --- CASO 1: Consulta de Saldo ---
                  caso 1
                     limpatela
                     escreval ("----------------------------------------------------------------")
                     escreval ("    Olá ",nome[posicao]," O seu saldo atual é: R$ ",saldo[posicao]:5:2)
                     escreval ("----------------------------------------------------------------")
                     escreval ("")
                     // Reimprime o menu alternativo simplificado interno
                     escreval ("-----------------------------------------")
                     escreval ("              Menu Inicial               ")
                     escreval ("-----------------------------------------")
                     escreval ("   Digite [1] Para fazer depósito  ")
                     escreval ("   Digite [2] Para fazer uma transferência via pix.  ")
                     escreval ("   Digite [3] para extrato de saída. ")
                     escreval ("   Digite [4] para extrato de depósito. ")
                     escreval ("   Digite [5] para fazer saque.  ")
                     escreval ("   Digite [6] Para sair.  ")
                     leia(opcao)

                     // Normaliza o avanço do índice da opção digitada no submenu
                     para i <- 1 ate 6 faca
                        se (opcao = i ) entao
                           opcao <- opcao + 1
                           interrompa
                        fimse
                     fimpara

                  // --- CASO 2: Depósito em Conta ---
                  caso 2
                     limpatela
                     escreval ("-------------------------------------")
                     escreval ("    Bem-Vindo a área de deposito   ")
                     repita
                        escreval ("-------------------------------------")
                        escreval ("    Quanto vai depositar   ")
                        leia (deposito)

                        se (validaNumero(deposito))entao
                           aux <- caracpnum(deposito)
                           saldo[posicao] <- aux + saldo[posicao] // Atualiza o saldo
                           
                           // Grava o evento na matriz de extrato de depósito do usuário ativo
                           para i <- 1 ate 5 faca
                              se (extratoDeposito[posicao, i] = 0) entao
                                 extratoDeposito[posicao, i] <- aux
                                 interrompa
                              fimse
                           fimpara
                           sair <- "NAO"
                        senao
                           escreval ("    Erro! Valor inválido. Digite apenas números. ")
                           escreval ("")
                           escreval ("    Gostaria de tentar novamente? [ SIM/NÃO ] ")
                           leia(sair)
                           validaSim(sair)
                           limpatela
                        fimse
                     ate ((sair = "NÃO") ou (sair = "NAO"))

                     limpatela
                     escreval ("------------------------------------")
                     escreval ("    Depósito concluido com sucesso  ")
                     escreval ("------------------------------------")
                     escreval ("")
                     menuInicial()

                  // --- CASO 3: Transferência Eletrônica (PIX) ---
                  caso 3
                     repita
                        limpatela
                        escreval ("----------------------------------------")
                        escreval ("    Bem-Vindo a área de transferência   ")
                        escreval ("   Digite o nome da pessoa que vai receber  ")
                        leia (entrada_usuario)
                        escreval ("   Digite a agência da pessoa que vai receber  ")
                        leia (entrada_agencia)
                        escreval ("   Digite a conta da pessoa que vai receber  ")
                        leia (entrada_conta)
                        escreval ("   Digite o valor da transferência  ")
                        leia (transferencia)

                        continuar <- falso
                        erro <- verdadeiro

                        // Inicia as validações dos dados do favorecido
                        se validaLetras(entrada_usuario) entao
                           se (validaNumero(entrada_agencia)) e (compr(entrada_agencia) = 4) entao
                              se (validaNumero(entrada_conta)) e (compr(entrada_conta) = 5) entao
                                 // Busca o usuário recebedor na base de dados
                                 para i <- 1 ate 5 faca
                                     se (nome[i] = entrada_usuario) entao
                                        posicaoReceber <- i
                                        // Valida se agência e conta do recebedor estão certas
                                        se (entrada_agencia = agencia) e (entrada_conta = conta[posicaoReceber]) entao
                                           erro <- verdadeiro
                                           interrompa
                                        senao
                                           erro <- falso
                                        fimse
                                     senao
                                        erro <- falso
                                     fimse
                                 fimpara
                                 se validaNumero(transferencia) entao
                                    continuar <- verdadeiro
                                 senao
                                    erro <- falso
                                 fimse
                              senao
                                 erro <- falso
                              fimse
                           senao
                              erro <- falso
                           fimse
                        senao
                           erro <- falso
                        fimse

                        // Se os dados cadastrais do recebedor estão OK, pede senha e valida o saldo
                        se (erro = verdadeiro) entao
                           repita
                              limpatela
                              escreval ("----------------------------------------")
                              escreval ("    Confira os dados da transferência   ")
                              escreval ("----------------------------------------")
                              escreval ("    Nome: ",entrada_usuario)
                              escreval ("    Agéncia: ",entrada_agencia)
                              escreval ("    Conta: ",entrada_conta)
                              escreval ("    Valor: ",transferencia)
                              escreval ("-------------------------------------------------")
                              escreval ("  Para confimar a transferência digite sua senha. ")
                              leia(entrada_senha)
                              aux <- caracpnum(transferencia)
                              sair <- "NAO"

                              se (senha[posicao] <> entrada_senha) entao
                                 escreval ("    Erro! Senha inválida    ")
                                 escreval ("    Gostaria de tentar novamente? [ SIM/NÃO ] ")
                                 leia (sair)
                                 validaSim(sair)
                              fimse

                              // Valida a margem de saldo em conta para realizar a operação
                              se (saldo[posicao] < aux) entao
                                 escreval ("    Erro! Saldo insuficiente.    ")
                                 escreval ("    Seu saldo atual é de: R$ ",saldo[posicao])
                                 escreval ("    Gostaria de tentar novamente? [ SIM/NÃO ] ")
                                 leia (sair)
                                 validaSim(sair)
                                 escreval ("   Digite [2] Para fazer depósito  ")
                                 leia(opcao)
                                 se (sair = "SIM") e (opcao <> 2) e (saldo[posicao] = 0) entao
                                    escreval ("   Saldo insuficiente. Finalizando o programa com segurança  ")
                                    fimalgoritmo
                                 senao
                                    sair <- "NAO"
                                    erro <- falso
                                 fimse
                              fimse
                           ate (sair = "NAO")

                        senao
                           escreval ("    Erro! Dados inválido.  ")
                           escreval ("    Gostaria de tentar novamente? [ SIM/NÃO ] ")
                           leia (sair)
                           validaSim(sair)
                        fimse
                     ate (sair = "NAO") e (erro = verdadeiro)

                     // Efetivação do PIX: Deduz de um usuário e adiciona no outro
                     se (senha[posicao] = entrada_senha) e (saldo[posicao] >= aux) entao
                        aux <- caracpnum(transferencia)
                        saldo[posicao] <- saldo[posicao] - aux
                        saldo[posicaoReceber] <- saldo[posicaoReceber] + aux

                        // Grava o débito na matriz de saídas do remetente
                        para i <- 1 ate 5 faca
                           se (extratoSaida[posicao, i] = 0) entao
                              extratoSaida[posicao, i] <- aux
                              interrompa
                           fimse
                        fimpara

                        // Registra o nome do favorecido associado a esta transação
                        para i <- 1 ate 5 faca
                           se (nomeRecebido[posicao, i] = "") entao
                              nomeRecebido[posicao, i] <- entrada_usuario
                              interrompa
                           fimse
                        fimpara
                              
                        limpatela
                        escreval ("-----------------------------------------")
                        escreval ("    Transferência efetuada com sucesso.  ")
                        escreval ("-----------------------------------------")
                        escreval ("    Nome: ",entrada_usuario)
                        escreval ("    Agência: ",entrada_agencia)
                        escreval ("    conta: ",entrada_conta)
                        escreval ("    Valor: ",transferencia)
                        menuInicial()
                     fimse

                  // --- CASO 4: Relatório de Extrato de Saídas (Débitos) ---
                  caso 4
                     repita
                        limpatela
                        escreval ("---------------------------------------------------------------")
                        escreval ("               Bem-Vindo a área de extrato de saida  ")
                        escreval ("---------------------------------------------------------------")
                        escreval ("    Digite [1] Para extrato do mais recente para o mais antigo ")
                        escreval ("")
                        escreval ("    Digite [2] Para extrato do mais antigo para o mais recente ")
                        leia(opcao)

                        // Exibe invertendo a matriz (Mais recente ao mais antigo)
                        se (opcao = 1) entao
                           inverte()
                           para i <- 1 ate 5 faca
                              se (extratoSaida[posicao, i] <> 0) entao
                                 escreval ("  transferência efetuada para: ",nomeRecebido[posicao, i]," no valor: ",extratoSaida[posicao, i])
                              fimse
                           fimpara
                           escreval ("----------------------------------------------------------------------------------------------------")
                           para i <- 1 ate 5 faca
                              se (saque[posicao, i] <> "") entao
                                 escreval ("  saque realizado: ",saque[posicao, i])
                              fimse
                           fimpara
                           sair <- "NAO"
                           inverte() // Desfaz a inversão para manter a integridade cronológica original
                        fimse

                        // Exibe na ordem cronológica natural de inserção
                        se (opcao = 2) entao
                           para i <- 1 ate 5 faca
                              se (extratoSaida[posicao, i] <> 0) entao
                                 escreval("   transferência efetuada para: ",nomeRecebido[posicao, i]," no valor: ",extratoSaida[posicao, i])
                              fimse
                           fimpara
                           para i <- 1 ate 5 faca
                              se (saque[posicao, i] <> "") entao
                                 escreval (" saque realizado: ",saque[posicao, i])
                              fimse
                           fimpara
                           sair <- "NAO"
                        fimse
                        se (opcao <> 1) e (opcao <> 2) entao
                           escreval ("    Opção inválida  ")
                           escreval ("    Gostaria de tentar novamente? [ SIM/NÃO ] ")
                           leia (sair)
                           validaSim(sair)
                        fimse
                     ate (sair = "NAO")
                     menuInicial()
                     
                  // --- CASO 5: Relatório de Extrato de Depósitos (Créditos) ---
                  caso 5
                     repita
                        limpatela
                        escreval ("---------------------------------------------------------------")
                        escreval ("               Bem-Vindo a área de extrato de depódito  ")
                        escreval ("---------------------------------------------------------------")
                        escreval ("    Digite [1] Para extrato do mais recente para o mais antigo ")
                        escreval ("")
                        escreval ("    Digite [2] Para extrato do mais antigo para o mais recente ")
                        leia(opcao)

                        // Varre a matriz de trás para frente simulando exibição reversa
                        se (opcao = 1) entao
                           aux <- 0
                           para i <- 5 ate 1 passo -1 faca
                              se (extratoDeposito[posicao, i] <> 0) entao
                                 aux <- (extratoDeposito[posicao, i] + aux)
                                 escreval ("  Depósitos efetuados: ",extratoDeposito[posicao, i])
                              fimse
                           fimpara
                           escreval ("")
                           escreval ("O total de depósito foi: ",aux)
                           sair <- "NAO"
                        fimse
                        
                        // Varre do início ao fim (Mais antigo ao mais recente)
                        se (opcao = 2) entao
                           aux <- 0
                           para i <- 1 ate 5 faca
                              se (extratoDeposito[posicao, i] <> 0) entao
                                 aux <- (extratoDeposito[posicao, i] + aux)
                                 escreval("   Depósitos efetuados: ",extratoDeposito[posicao, i])
                              fimse
                           fimpara
                           escreval ("")
                           escreval ("O total de depósito foi: ",aux)
                           sair <- "NAO"
                        fimse
                        se (opcao <> 1) e (opcao <> 2) entao
                           escreval ("    Opção inválida  ")
                           escreval ("    Gostaria de tentar novamente? [ SIM/NÃO ] ")
                           leia (sair)
                           validaSim(sair)
                        fimse
                     ate (sair = "NAO")
                     menuInicial()

                  // --- CASO 6: Retirada de Dinheiro em Espécie (Saque) ---
                  caso 6
                     repita
                        limpatela
                        escreval ("--------------------------------------")
                        escreval ("       Bem-Vindo a área de saque.  ")
                        escreval ("--------------------------------------")
                        escreval ("   Qual o valor desejado para saque?  ")
                        leia(transferencia)
                        escreval ("  Para confimar o saque digite sua senha. ")
                        leia(entrada_senha)

                        continuar <- falso
                        erro <- falso
                        
                        // Valida se o  valor é numérico, se a senha confere e se há saldo disponível
                        se validaNumero(transferencia) entao
                           se (validaNumero(entrada_senha)) e (senha[posicao] = entrada_senha) entao
                              aux <- caracpnum(transferencia)
                              se (saldo[posicao] >= aux) entao
                                 continuar <- verdadeiro
                              senao
                                 erro <- verdadeiro
                              fimse
                           senao
                              erro <- verdadeiro
                           fimse
                        senao
                           erro <- verdadeiro
                        fimse
                        
                        // Se todas as regras de negócio passarem, o saque é processado
                        se (continuar = verdadeiro) entao
                           saldo[posicao] <- saldo[posicao] - aux

                           // Grava o valor do saque no vetor de histórico convertendo real para texto
                           para i <- 1 ate 5 faca
                              se (saque[posicao, i] = "") entao
                                 saque[posicao, i] <- numpcarac(aux)
                                 interrompa
                              fimse
                           fimpara
                           escreval ("----------------------------------")
                           escreval ("    Saque efetuado com sucesso.   ")
                           escreval ("----------------------------------")
                           menuInicial()
                           sair <- "SIM" // Condição para quebrar o loop do caso 6
                        fimse
                        se (erro = verdadeiro) entao
                           escreval ("    Erro! Senha ou saldo inválido.  ")
                           escreval ("    Gostaria de tentar novamente? [ SIM/NÃO ] ")
                           leia (sair)
                           validaSim(sair)
                        fimse
                     ate (sair = "SIM")

                  // --- CASO 7: Saída logoff ---
                  caso 7
                     escreval ("")
                     
                  outrocaso
                     escreval ("     Erro! Opção inválida.   ")
                     menuInicial()
               fimescolha
            ate (opcao = 7) // Encerra a sessão atual e desloga o usuário do menu principal
            entrada_usuario <- "2"
         fimenquanto
         
         // ----------------------------------------------------------------------
         // MENU FINAL DE CONTROLE DE INFRAESTRUTURA
         // Objetivo: Tratar a ação global do software após um usuário fazer logoff
         // ----------------------------------------------------------------------
         escreval ("---------------------------------")
         escreval ("   Digite [1] para fazer novo cadastro?   ")
         escreval ("")
         escreval ("   Digite [2] para loga com outra conta?  ")
         escreval ("")
         escreval ("   Digite [3] para finalizar o programa?  ")
         leia(opcao)
         
         // Opção 1: Configura as flags de controle para reiniciar o Loop 1 (Cadastro)
         se (opcao = 1) entao
            continuar <- verdadeiro
            erro <- falso
            entrada_usuario <- "1"
         fimse
         
         // Opção 2: Pula o loop de cadastros e redireciona diretamente ao Loop 2 (Login)
         se (opcao = 2) entao
            erro <- verdadeiro
            entrada_usuario <- "1"
         fimse
         
         // Opção 3: Quebra todas as flags booleanas finalizando o ecossistema do script
         se (opcao = 3) entao
         se (opcao = 3)entao
            continuar <- falso
            erro <- falso
         fimse
      fimenquanto
   fimenquanto
   escreval ("    Encerrando o programa com segurança  ")

fimalgoritmo



