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
   conta: vetor [1..5] de caractere
   senha: vetor [1..5] de caractere
   saldo: vetor [1..5] de real
   agencia: caractere
   cadastro: caractere
   cadastroSenha: caractere
   sair: caractere
   opcao: inteiro
   conta_gerada:inteiro
   entrada_usuario: caractere
   entrada_agencia: caractere
   entrada_conta: caractere
   entrada_senha: caractere
   deposito: caractere
   aux: real
   posicao: inteiro
   i:inteiro
   continuar, encontrado: logico
   
procedimento opcaoEntrada()
inicio
   escreval ("    [1] Para acessar sua conta. ")
   escreval ("    [2] para sair  ")
   leia(entrada_usuario)
fimprocedimento

procedimento  validaSim()
inicio
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
      se (codigo < 48) ou (codigo > 57) ou (codigo = 44) ou (codigo = 46)entao
          valido <- falso
      fimse
   fimpara
   retorne valido
fimfuncao

procedimento organizarVetor()
var
   chave_nome: caractere
   chave_conta: caractere
   chave_senha: caractere
   chave_saldo: real
   i, j: inteiro
inicio
   para i <- 2 ate 5 faca
      se (nome[i] <> "") entao
         chave_nome <- nome[i]
         chave_conta <- conta[i]
         chave_senha <- senha[i]
         chave_saldo <- saldo[i]

         j <- (i - 1)
         enquanto (j > 0) faca
            se(nome[j] > chave_nome) e (nome[j] <> "") entao
               nome[j + 1] <- nome[j]
               conta[j + 1] <- conta[j]
               senha[j + 1] <- senha[j]
               saldo[j + 1] <- saldo[j]

               j <- (j - 1)
            senao
               interrompa
            fimse
         fimenquanto

            nome[j + 1] <- chave_nome
            conta[j + 1] <- chave_conta
            senha[j + 1] <- chave_senha
            saldo[j + 1] <- chave_saldo
      fimse
   fimpara
fimprocedimento

inicio


     agencia <- "0001"
     conta_gerada <- 12344
    
    para i <- 1 ate 5 faca
       saldo[i] <- 0
    fimpara
 //área de cadastrar none do usuário
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
         
         para i <- 1 ate 5 faca
            se (nome[i] = "") entao
               nome[i] <- cadastro
               conta_gerada <- conta_gerada + 1
               conta[i] <-numpcarac(conta_gerada)
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

         validaSim()
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
         
         validaSim()
      fimse
   ate (continuar = verdadeiro)
   
   para i <- 1 ate 5 faca
      se (nome[i] = cadastro) entao
         limpatela
         escreval ("Cadastro efetuado com sucesso. ")
         escreval ("-----------------------------------------")
         escreval ("agencia: ",agencia)
         escreval ("conta: ",conta[i])
         escreval ("usuário: ",nome[i])
         escreval ("senha: ",senha[i])
         escreval ("-----------------------------------------")
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
     
     se (entrada_usuario = "2") entao
        escreval ("    Encerrando o programa com segurança  ")
        fimalgoritmo
     fimse
   
     repita
        se(entrada_usuario <> "1") e (entrada_usuario <> "2") entao
           escreval ("   Digite apena [ 1/2 ] ")
           leia (entrada_usuario)
           
           se (entrada_usuario = "2") entao
              escreval ("    Encerrando o programa com segurança  ")
              fimalgoritmo
           fimse
        fimse
     ate (entrada_usuario = "1")
   fimse
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
                 escreval ("   Digite apena [ 1/2 ] ")
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

enquanto (entrada_usuario = "1") faca
  repita
   limpatela
   escreval ("-------------------------------")
   escreval ("    Digite o nome do usuário   ")
   leia(entrada_usuario)
   escreval ("-------------------------------")
   escreval ("    Digite sua agencia    ")
   leia(entrada_agencia)
   escreval ("-------------------------------")
   escreval ("    Digite sua conta    ")
   leia(entrada_conta)
   escreval ("-------------------------------")
   escreval ("    Digite sua senha   ")
   leia(entrada_senha)

   entrada_usuario <- maiusc(entrada_usuario)
   encontrado <- falso

   se (entrada_agencia = agencia) entao
      para i <- 1 ate 5 faca
         se (entrada_usuario = maiusc(nome[i])) e (entrada_conta = conta[i]) e (entrada_senha = senha[i]) entao
            encontrado <- verdadeiro
            posicao <- i
            interrompa
         fimse
      fimpara
   fimse
   
   se (encontrado = verdadeiro) entao
      limpatela
      escreval ("--------------------------------")
      escreval ("    Bem-Vindo ",nome[posicao])
      escreval ("    [1] Para ver saldo.   ")
      escreval ("    [2] Para fazer deposito  ")
      escreval ("    [3] Para fazer uma transferência via pix.  ")
      escreval ("    [4] para extrato de saída. ")
      escreval ("    [5] para extrato de depósito. ")
      escreval ("    [6] para fazer saque.  ")
      escreval ("    [7] Para sair.  ")
      leia(opcao)
      sair <- "NÃO"
   senao
      escreval ("    ERRO! Usuário não encontrado   ")
      escreval ("    Gostaria de tentar novamente [ SIM/NÃO ] ")
      leia (sair)
      
      validaSim()
   fimse
  ate ((sair = "NAO") ou (sair = "NÃO"))
 repita
   escolha opcao
      caso 1
          limpatela
          escreval ("----------------------------------------------------------------")
          escreval ("    Olá ",nome[posicao]," O seu saldo atual é: R$ ",saldo[posicao]:5:2)
          escreval ("----------------------------------------------------------------")
          escreval ("    [1] Para fazer deposito  ")
          escreval ("    [2] Para fazer uma transferência via pix.  ")
          escreval ("    [3] para extrato de saída. ")
          escreval ("    [4] para extrato de depósito. ")
          escreval ("    [5] para fazer saque.  ")
          escreval ("    [6] Para sair.  ")
          leia(opcao)
           para i <- 1 ate 6 faca
              se (opcao = i ) entao
                 opcao <- opcao + 1
                 interrompa
              fimse
           fimpara
      caso 2
          limpatela
          escreval ("-------------------------------------")
          escreval ("    Bem-Vindo a área de deposito   ")
        repita
          escreval ("-------------------------------------")
          escreval ("    Quanto vai deposita   ")
          leia (deposito)
          
          se (validaNumero(deposito))entao
                aux <- caracpnum(deposito)
                saldo[posicao] <- aux + saldo[posicao]
                sair <- "NAO"
          senao
             escreval ("    Erro! Valor inválido. Digite apenas número. ")
             escreval ("")
             escreval ("    Gostaria de tentar novamente? [ SIM/NÃO ] ")
             leia(sair)
             validaSim()
             limpatela
          fimse
        ate ((sair = "NÃO") ou (sair = "NAO"))
        
          limpatela
          escreval ("------------------------------------")
          escreval ("    Deposito comcluido com sucesso  ")
          escreval ("------------------------------------")
          escreval ("    [1] Para ver saldo.   ")
          escreval ("    [2] Para fazer deposito  ")
          escreval ("    [3] Para fazer uma transferência via pix.  ")
          escreval ("    [4] para extrato de saída. ")
          escreval ("    [5] para extrato de depósito. ")
          escreval ("    [6] para fazer saque.  ")
          escreval ("    [7] Para sair.  ")
          leia(opcao)
      caso 3
   
      caso 4
   
      caso 5

      caso 6
      
      outrocaso
          escreval (" erro")

   fimescolha
 ate (opcao = 7)
fimenquanto
   escreval ("    Encerrando o programa com segurança  ")
   
fimalgoritmo



