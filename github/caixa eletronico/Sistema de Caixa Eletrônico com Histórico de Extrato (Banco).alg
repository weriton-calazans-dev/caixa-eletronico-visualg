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
   nome: vetor [1..5] de caractere
   conta: vetor [1..5] de inteiro
   senha: vetor [1..5] de caractere
   agencia: caractere
   cadastro: caractere
   cadastroSenha: caractere
   conta_padrao: inteiro
   sair: caractere
   opcao: caractere
   enter: caractere
   i:inteiro
   continuar: logico
procedimento opcaoEntrada()
inicio
   escreval ("    [1] Para acessar sua conta. ")
   escreval ("    [2] Para fazer uma transferência via pix. ")
   escreval ("    [3] para ver saldo.   ")
   escreval ("    [4] para extrato de saída via pix. ")
   escreval ("    [5] para extrato de depósito. ")
   escreval ("    [6] Para sair.  ")
   leia(opcao)
fimprocedimento
funcao validaLetras(texto: caractere) : logico
var
   proibidos: caractere
   i: inteiro
   valido: logico
inicio
   valido <- verdadeiro

   proibidos <- "0123456789!@#$%¨&*()_+-=[]{}?/;,.:>_<|`´"

   para i <- 1 ate compr(proibidos) faca
      se pos(copia(proibidos, i, 1), texto) > 0 entao
         valido <- falso
         interrompa
      fimse
   fimpara

   retorne valido
fimfuncao

funcao validaNumero (numero: caractere) : logico
var
   valido: logico
   i,codigo: inteiro
inicio
   valido <- verdadeiro
   para i <- 1 ate compr(numero) faca
      codigo <- asc(copia(numero, i, 1))
      se (codigo < 48) ou (codigo > 57) entao
          valido <- falso
      fimse
   fimpara
   retorne valido
fimfuncao

procedimento organizarVetor()
var
   chave_nome: caractere
   chave_conta: inteiro
   chave_senha: caractere
   i, j: inteiro
inicio
   para i <- 2 ate 5 faca
      se (nome[i] <> "") entao
         chave_nome <- nome[i]
         chave_conta <- conta[i]
         chave_senha <- senha[i]

         j <- (i - 1)
         enquanto (j > 0) faca
            se(nome[j] > chave_nome) e (nome[j] <> "") entao
               nome[j + 1] <- nome[j]
               conta[j + 1] <- conta[j]
               senha[j + 1] <- senha[j]

               j <- (j - 1)
            senao
               interrompa
            fimse
         fimenquanto

            nome[j + 1] <- chave_nome
            conta[j + 1] <- chave_conta
            senha[j + 1] <- chave_senha
      fimse
   fimpara
fimprocedimento

inicio

   //área de cadastrar none do usuário
     agencia <- "0001"
     conta[1] <- 12345
     conta[2] <- 12346
     conta[3] <- 12347
     conta[4] <- 12348
     conta[5] <- 12349

repita
   continuar <- falso
   repita
      limpatela
      escreval ("--------------------------------------")
      escreval ("    Bem-vindo à área de cadastro     ")
      escreval ("--------------------------------------")
      escreval ("    Digite seu nome!  ")
      leia (cadastro)
      se (validaLetras(cadastro)) e (cadastro <> "") entao
         limpatela
         escreval ("----------------------------------------------------------")
         escreval ("    Nome '",cadastro,"' cadastrado com sucesso.  ")
         escreval ("----------------------------------------------------------")
         escreval ("    Pressione Enter para continuar...  ")
         leia (enter)
         
         para i <- 1 ate 5 faca
            se (nome[i] = "") entao
               nome[i] <- cadastro
               interrompa
            fimse
         fimpara
          continuar <- verdadeiro
      senao
         escreval ("    Erro! nome inválido. Digite apenas letras. ")
         escreval ("")
         escreval ("    Gostaria de tentar novamente? [ SIM/NÃO ] ")
         leia(sair)
         sair <- maiusc(sair)

         se (sair = "SIM") entao
            limpatela
         fimse
               
         se (sair = "NAO") ou (sair = "NÃO") entao
            escreval ("    Encerrando o programa com segurança  ")
            fimalgoritmo
         fimse
               
         se (sair <> "SIM") e (sair <> "NAO") e (sair <> "NÃO") entao
            repita
               escreval ("    Erro! digite apenas [ SIM/NÃO ] para tentar novamente. ")
               leia (sair)
               sair <- maiusc(sair)

               se (sair = "NÃO") ou (sair = "NAO") entao
                  escreval ("    Encerrando o programa com segurança  ")
                  fimalgoritmo
               fimse
            ate (sair = "SIM")
         fimse
      fimse
   ate (continuar = verdadeiro)
   //área de cadastrar senha
     continuar <- falso
   repita
      escreval ("--------------------------------------------")
      escreval ("    Cadastre sua senha com apenas 4 números  ")
      leia(cadastroSenha)
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
         
         se (sair = "SIM") entao
            limpatela
         fimse
         
         se (sair = "NÃO") ou (sair = "NAO") entao
            escreval ("    Encerrando o programa com segurança.  ")
            fimalgoritmo
         fimse
         
         se (sair <> "NÃO") e (sair <> "NAO") e (sair <> "SIM")entao
            repita
               escreval ("    Erro! Digite apenas [ SIM/NÃO ] para continuar.  ")
               leia (sair)
               sair <- maiusc(sair)
               
               se (sair = "NÃO") ou (sair = "NAO") entao
                  escreval ("    Encerrando o programa com segurança.  ")
                  fimalgoritmo
               fimse
               
            ate (sair = "SIM")
         fimse
      fimse
   ate (continuar = verdadeiro)
   para i <- 1 ate 5 faca
      se (nome[i] = cadastro) entao
         limpatela
         escreval ("-----------------------------------------")
         escreval ("agencia: ",agencia)
         escreval ("conta: ",conta[i])
         escreval ("usuário: ",nome[i])
         escreval ("senha: ",senha[i])
         escreval ("-----------------------------------------")
         escreval ("Cadastro efetuado com sucesso. ")
         escreval ("")
         escreval ("Salve seus dados para acessar sua conta. ")
         escreval ("-----------------------------------------")
      fimse
   fimpara
   organizarVetor()
   escreval ("  Para fazer novo cadastro digite [ SIM/NÃO ] ")
   leia(sair)
   sair <- maiusc(sair)
   se (sair = "SIM") entao
      limpatela
   fimse
   se (sair = "NAO") ou (sair = "NÃO") entao
     opcaoEntrada()
   fimse
   se (sair <> "NÃO") e (sair <> "NAO") e (sair <> "SIM")entao
      repita
         escreval ("    Erro! Digite apenas [ SIM/NÃO ] para continuar.  ")
         leia (sair)
         sair <- maiusc(sair)

         se (sair = "NÃO") ou (sair = "NAO") entao
           opcaoEntrada()
         fimse
      ate (sair = "SIM")
   fimse

ate (sair = "NAO")
fimalgoritmo



