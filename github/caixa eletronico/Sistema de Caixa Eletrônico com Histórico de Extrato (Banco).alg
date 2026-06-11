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
   nomeRecebido: vetor [1..5] de caractere
   saque: vetor [1..5] de caractere
   saldo: vetor [1..5] de real
   extratoSaida:vetor [1..5] de real
   extratoDeposito: vetor [1..5] de real
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
   aux: real
   posicao: inteiro
   i:inteiro
   continuar, encontrado, erro: logico
   
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
procedimento opcaoEntrada()
inicio
   escreval ("    [1] Para acessar sua conta. ")
   escreval ("    [2] Para sair  ")
   leia(entrada_usuario)
fimprocedimento

procedimento  validaSim(var a:caractere)
inicio
   a <- maiusc(a)
   se (a = "SIM") entao
      limpatela
   fimse

   se (a = "NAO") ou (a = "NÃO") entao
      escreval ("    Encerrando o programa com segurança  ")
      fimalgoritmo
   fimse

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
   chave_saque: caractere
   chave_saldo: real
   chave_extratoSaida: real
   chave_extratoDeposito: real
   i, j: inteiro
inicio
   para i <- 2 ate 5 faca
      se (nome[i] <> "") entao
         chave_nome <- nome[i]
         chave_conta <- conta[i]
         chave_senha <- senha[i]
         chave_saldo <- saldo[i]
         chave_extratoSaida <- extratoSaida[i]
         chave_extratoDeposito <- extratoDeposito[i]
         chave_saque <- saque[i]
         
         j <- (i - 1)
         enquanto (j > 0) faca
            se(nome[j] > chave_nome) e (nome[j] <> "") entao
               nome[j + 1] <- nome[j]
               conta[j + 1] <- conta[j]
               senha[j + 1] <- senha[j]
               saldo[j + 1] <- saldo[j]
               extratoSaida[j + 1] <- extratoSaida[j]
               extratoDeposito[j + 1] <- extratoDeposito[j]
               saque[j + 1] <- saque[j]
               
               j <- (j - 1)
            senao
               interrompa
            fimse
         fimenquanto

            nome[j + 1] <- chave_nome
            conta[j + 1] <- chave_conta
            senha[j + 1] <- chave_senha
            saldo[j + 1] <- chave_saldo
            extratoSaida[j + 1] <- chave_extratoSaida
            extratoDeposito[j + 1] <- chave_extratoDeposito
            saque[j + 1] <- chave_saque
      fimse
   fimpara
fimprocedimento

procedimento inverte()
var
   aux4: caractere
   aux3: real
   aux2: caractere
   aux: real
   esq, dir: inteiro
inicio
   esq <- 1
   dir <- 5
   enquanto (esq < dir) faca
      aux <- extratoSaida[esq]
      extratoSaida[esq] <- extratoSaida[dir]
      extratoSaida[dir] <- aux
      
      aux2 <- nomeRecebido[esq]
      nomeRecebido[esq] <- nomeRecebido[dir]
      nomeRecebido[dir] <- aux2
      
      aux3 <- extratoDeposito[esq]
      extratoDeposito[esq] <- extratoDeposito[dir]
      extratoDeposito[dir] <- aux3
      
      aux4 <- saque[esq]
      saque[esq] <- saque[dir]
      saque[dir] <- aux4
      
      esq <- esq + 1
      dir <- dir - 1
   fimenquanto

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
            escreval ("    Erro! Nome inválido. Digite apenas letras. ")
            escreval ("")
            escreval ("    Gostaria de tentar novamente? [ SIM/NÃO ] ")
            leia(sair)
            sair <- maiusc(sair)

            validaSim(sair)
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
         
            validaSim(sair)
         fimse
      ate (continuar = verdadeiro)
   
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
      repita
         escolha opcao
            caso 1
               limpatela
               escreval ("----------------------------------------------------------------")
               escreval ("    Olá ",nome[posicao]," O seu saldo atual é: R$ ",saldo[posicao]:5:2)
               escreval ("----------------------------------------------------------------")
               escreval ("")
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
                  escreval ("    Quanto vai depositar   ")
                  leia (deposito)
          
                  se (validaNumero(deposito))entao
                     aux <- caracpnum(deposito)
                     saldo[posicao] <- aux + saldo[posicao]
                     para i <- 1 ate 5 faca
                        se (extratoDeposito[i] = 0) entao
                           extratoDeposito[i] <- aux
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
                
                  se validaLetras(entrada_usuario) entao
                     se (validaNumero(entrada_agencia)) e (compr(entrada_agencia) = 4) entao
                        se (validaNumero(entrada_conta)) e (compr(entrada_conta) = 5) entao
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
               
               se (senha[posicao] = entrada_senha) e (saldo[posicao] >= aux) entao
                  aux <- caracpnum(transferencia)
                  saldo[posicao] <- saldo[posicao] - aux
                  para i <- 1 ate 5 faca
                     se (extratoSaida[i] = 0) entao
                        extratoSaida[i] <- aux
                        interrompa
                     fimse
                  fimpara
                  
                  para i <- 1 ate 5 faca
                     se (nomeRecebido[i] = "") entao
                        nomeRecebido[i] <- entrada_usuario
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
               
                  se (opcao = 1) entao
                     inverte()
                     para i <- 1 ate 5 faca
                        se (extratoSaida[i] <> 0) entao
                           escreval ("  transferência efetuada para: ",nomeRecebido[i]," no valor: ",extratoSaida[i])
                        fimse
                     fimpara
                     para i <- 1 ate 5 faca
                        se (saque[i] <> "") entao
                           escreval (" saque realizado: ",saque[i])
                        fimse
                     fimpara
                     sair <- "NAO"
                     inverte()
                  fimse
                  se (opcao = 2) entao
                     para i <- 1 ate 5 faca
                       se (extratoSaida[i] <> 0) entao
                          escreval("   transferência efetuada para: ",nomeRecebido[i]," no valor: ",extratoSaida[i])
                       fimse
                    fimpara
                    para i <- 1 ate 5 faca
                        se (saque[i] <> "") entao
                           escreval (" saque realizado: ",saque[i])
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

                  se (opcao = 1) entao
                     inverte()
                     aux <- 0
                     para i <- 1 ate 5 faca
                        se (extratoDeposito[i] <> 0) entao
                           aux <- (extratoDeposito[i] + aux)
                           escreval ("  Depósitos efetuados: ",extratoDeposito[i])
                        fimse
                     fimpara
                     escreval ("")
                     escreval ("O total de depósito foi: ",aux)
                     sair <- "NAO"
                     inverte()
                  fimse
                  se (opcao = 2) entao

                     aux <- 0
                     para i <- 1 ate 5 faca
                        se (extratoDeposito[i] <> 0) entao
                           aux <- (extratoDeposito[i] + aux)
                           escreval("   Depósitos efetuados: ",extratoDeposito[i])
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
                  se (continuar = verdadeiro) entao
                     saldo[posicao] <- saldo[posicao] - aux
                     para i <- 1 ate 5 faca
                        se (saque[i] = "") entao
                           saque[i] <- numpcarac(aux)
                           interrompa
                        fimse
                     fimpara
                     escreval ("----------------------------------")
                     escreval ("    Saque efetuado com sucesso.   ")
                     escreval ("----------------------------------")
                     menuInicial()
                     sair <- "SIM"
                  fimse
                  se (erro = verdadeiro) entao
                     escreval ("    Erro! Senha ou saldo inválido.  ")
                     escreval ("    Gostaria de tentar novamente? [ SIM/NÃO ] ")
                     leia (sair)
                     validaSim(sair)
                  fimse
               ate (sair = "SIM")
            outrocaso
               escreval ("     Erro! Opção inválida.   ")
               menuInicial()
         fimescolha
      ate (opcao = 7)
      entrada_usuario <- "2"
   fimenquanto
   escreval ("    Encerrando o programa com segurança  ")
   
fimalgoritmo



