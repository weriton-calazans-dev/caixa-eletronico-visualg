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
   senha: vetor [1..5] de caractere
   cadastro: caractere
   sair: caractere
   enter: caractere
   conta: inteiro
   i:inteiro
   continuar: logico

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

inicio

   repita
      continuar <- falso
      limpatela
      escreval ("--------------------------------------")
      escreval ("    Bem-vindo à área de cadastro     ")
      escreval ("--------------------------------------")
      escreval ("    Digite ser nome!  ")
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

      senao
         repita
            escreval ("    Erro! nome inválido. digite apenas letras. ")
            escreval ("")
            escreval ("    Gostaria de tentar novamente? [ SIM/NÃO ] ")
            leia(sair)
            sair <- maiusc(sair)

            se validaLetras(sair) entao
               se (sair = "SIM") entao
                  continuar  <-  verdadeiro
                  interrompa
               senao
                  se (sair = "NAO") ou (sair = "NÃO") entao
                     escreval ("    Encerrando o programa com segurança  ")
                     fimalgoritmo
                  senao
                     repita
                        escreval ("    Erro! digite apenas [ SIM/NÃO ] para tentar novamente. ")
                        leia (sair)
                        sair <- maiusc(sair)
                     ate (sair = "SIM") ou ((sair = "NAO") ou (sair = "NÃO"))
                     se sair = "SIM" entao
                        continuar <- verdadeiro
                     senao
                        escreval ("    Encerrando o programa com segurança  ")
                        fimalgoritmo
                     fimse
                  fimse
               fimse
            fimse
         ate (continuar = verdadeiro)
      fimse
   ate (continuar = falso)
   
   repita
      continuar <- falso
      escreval ("--------------------------------------------")
      escreval ("    Cadastre sua senha com apenas 4 número  ")
      leia(cadastro)
      se (validaNumero(cadastro)) e (compr(cadastro) = 4) e (cadastro <> "") entao
         escreval ("    Senha cadastrada com sucesso.   ")
         para i <- 1 ate 5 faca
            se (senha[i] = "") entao
               senha[i] <- cadastro
               interrompa
            fimse
         fimpara
         continuar <- verdadeiro
      fimse
      se (validaNumero(cadastro) = falso) ou (compr(cadastro) <> 4) entao
         escreval ("------------------------------------------")
         escreval ("             Senha inválida!              ")
         escreval ("    Deseja tentar novamente [ SIM/NÃO ]   ")
         escreval ("------------------------------------------")
         leia (sair)
         sair <- maiusc(sair)
         se validaLetras(sair) e (sair = "SIM") entao
            limpatela
            continuar <- verdadeiro
         senao
            se (validaLetras(sair) = falso) ou (sair <> "NÃO") ou (sair <> "NAO") entao
               repita
                  escreval ("    Erro! digite apenas [ SIM/NÃO ] para conatinuar.  ")
                  leia (sair)
                  sair <- maiusc(sair)
               ate (sair = "SIM") ou (sair = "NAO") ou (sair = "NÃO")
            se (sair = "SIM") entao
               continuar <- verdadeiro
            senao
               escreval ("    Encerando o programa com segurança.  ")
               fimalgoritmo
            fimse
         fimse
      fimse
   ate (continuar = falso)
   

fimalgoritmo
