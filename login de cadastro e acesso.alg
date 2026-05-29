algoritmo "3 EXECÍCIO DA IA PROFISSIONAL"
var
acesso0,agencia, agencia0, conta, conta0, senha0, nomeUsuario : caractere
acesso1, acesso2, transferencia, transferenciaMaius, novaTransferencia :caractere
contador4, tentaNovamente, validacao: caractere


agencia1, conta1, senha, contador0, senha1, senha2, contador3, codigo1 : inteiro

erroSenha, erro, erro1, erro2, passa: logico

saldo : real

//aria cripitografada de transferencia ------------------------------
pessoaReceber, senhaDigitada, valorEmviado, contador1 :caractere

contador, contador2, codigo, codigo0 :inteiro

valorEmviado0 : real

procedimento linhaSeparacao()
inicio
escreval ("-----------------------------------------------------")

fimprocedimento
inicio

nomeUsuario <- "Weriton"
agencia <- "0001"
conta <- "12345"
senha <- 2026
saldo <- 1250
 repita
linhaSeparacao()
escreval ("         Bem Vindo ao Nubank        ")
linhaSeparacao()
escreval ("")
escreval ("  Digite [1] Para Acessa Sua Conta  ")
escreval ("")
escreval ("  Digite [2] Para se Cadastra    ")
leia(acesso0)
//primeira area de acesso


se (acesso0 = "1") entao
   //repetição de seguraça com [enquanto]
   tentaNovamente <- "SIM"
   enquanto (tentaNovamente = "SIM") e ((agencia <> agencia0) ou (conta <> conta0) ou ( senha <> senha2)) faca
      limpatela
      linhaSeparacao()
      escreval ("    Digite o Número da Sua Agencia  ")
      leia (agencia0)
      linhaSeparacao()
      escreval ("    Digite o Número da Sua Conta    ")
      leia (conta0)
      linhaSeparacao()
      escreval ("    Digite a Sua Senha      ")
      leia (senha0)

      //validando o acesso da agencia se digito so número e transforma em [asc] liguagem so computador
      para contador0 <- 1 ate compr(agencia0) faca
         agencia1 <- asc (copia(agencia0, contador0, 1))
         se (agencia1 < 48) ou (agencia1 > 57) entao
            erro <- verdadeiro
         senao
            passa <- verdadeiro
         fimse
      fimpara

      //validando o acesso da conta se digito so número e transforma em [asc] liguagem so computador
      para contador0 <- 1 ate compr(conta0) faca
         conta1 <- asc (copia(conta0, contador0, 1))
         se (conta1 < 48) ou (conta1 > 57) entao
            erro1 <- verdadeiro
         senao
            passa <- verdadeiro
         fimse
      fimpara

      //validando o acesso da senha se digito so número e transforma em [asc] liguagem so computador
      para contador0 <- 1 ate compr(senha0) faca
         senha1 <- asc(copia(senha0, contador0, 1))
         se (senha1 < 48) ou (senha1 > 57) entao
            erro2 <- verdadeiro
         senao
            senha2 <- caracpnum(senha0)
            passa <- verdadeiro
         fimse

      fimpara

      se (erro = verdadeiro) ou (compr(agencia0) <> 4)entao

         escreval ("ERRO! Número da agencia invalida.")

      fimse

      se (erro1 = verdadeiro) ou (compr(conta0) <> 5) entao

         escreval ("ERRO! Número da conta invalida")

      fimse

      se (erro2 = verdadeiro) ou (compr(senha0) <> 4) entao

         escreval ("ERRO! Senha invalida")
      fimse
      //validação tanto do se é tudo número e o tamanho esta correto
      //
      se (erro = verdadeiro) ou (compr(agencia0) <> 4) ou (erro1 = verdadeiro) ou (compr(conta0) <> 5) ou (erro2 = verdadeiro) ou (compr(senha0) <> 4) entao

         escreval ("Gostaria de tenta novamente")
         leia (tentaNovamente)
         tentaNovamente <- maiusc(tentaNovamente)
      senao

         //PARA ESTORA O LAÇO DE REPETIÇÃO DO ENQUANTO

      fimse
   fimenquanto
senao
   escreval ("Opção invalida!")
   linhaSeparacao()
   escreval ("Gostaria de tentar novamente")
   linhaSeparacao()
   escreval ("     Digite [SIM] para tenta novamente ")
   escreval ("")
   escreval ("     Digite [NÃO] para Sair    ")
   leia (validacao)
   validacao <- maiusc(validacao)
fimse
 ate (validacao = "NAO")

// validando agencia, conta e senha
se (agencia = agencia0) e (conta = conta0) e ( senha = senha2) e (passa = verdadeiro) entao
   limpatela
   linhaSeparacao()
   escreval ("      Bem Vindo a Sua Conta      ")
   escreval ("------------",nomeUsuario,"------------")
   linhaSeparacao()
   escreval ("      Digiti [1] Para Ver Saldo   ")
   escreval ("")
   escreval ("      Digiti [2] Para Aria Pix    ")
   escreval ("")
   escreval ("      Digite [3] Para sair        ")
   linhaSeparacao()
   leia(acesso1)

   //acesso para ver saldo
   se (acesso1 = "1") entao
      limpatela
      linhaSeparacao()
      escreval ("    Olá! Seu saldo atual é: R$" ,saldo)
      linhaSeparacao()
      escreval ("      Digiti [1] Para Aria Pix    ")
      escreval ("")
      escreval ("      Digite [2] Para sair        ")
      linhaSeparacao()
      leia (acesso2)
   fimse
   // acesso para area pix tanto no primeiro acesso ou apois o saldo
   se (acesso1 = "2") ou (acesso2 = "1") entao

      limpatela
      linhaSeparacao()
      escreval ("     Olá! Bem Vindo Aria a Pix  ")
      linhaSeparacao()
      escreval ("     Com base no seu saldo atual   ")
      escreval ("           De: R$ ",saldo         )
      escreval ("     Para Fazer Transação Via Pix  ")
      escreval ("     Digite [SIM] para uma Transferecia ")
      escreval ("     Digite [NÃO] para Sair    ")
      leia (transferencia)

      // transformando em maiusculo para acessa a area pix
      transferenciaMaius <- maiusc(transferencia)
   fimse

   // acesso area de transferencia de pix
   se (transferenciaMaius = "SIM") entao

      novaTransferencia <- "SIM"

      enquanto ((saldo > 0) e (novaTransferencia = "SIM"))faca



         limpatela
         linhaSeparacao()
         escreval ("      Bem vindo a Area de Transferencia Pix      ")
         linhaSeparacao()
         escreval ("")
         escreval ("   Digite o valor Para Enviar   ")
         leia(valorEmviado)
         escreval ("     Digite o Nome da Pessoa    ")
         leia (pessoaReceber)
         escreval ("         Digite Sua Senha       ")
         leia (senhaDigitada)

         valorEmviado <- maiusc(valorEmviado)
         pessoaReceber <- maiusc(pessoaReceber)
         senhaDigitada <- maiusc(senhaDigitada)

         para contador3 <- 1 ate compr(pessoaReceber) faca
            contador4 <- copia (pessoaReceber, contador3, 1)
            codigo1 <- asc(copia(pessoaReceber, contador3, 1))
         fimpara
         se (codigo1 < 65) ou (codigo1 > 90) entao
            // validado se o usuario digito apenas letras
            escreval ("Erro! Nome de pessoa invalida")
            escreval ("   Você digito número  ")
            escreval ("Digiti [SIM] Para fazer nova transferencia.")
            escreval ("Digiti [NÃO] para Sair.")
            leia (novaTransferencia)

         senao

            //area criptografada
            para contador <- 1 ate compr(senhaDigitada) faca
               contador1 <-   copia (senhaDigitada, contador, 1)
               codigo <- asc (copia (senhaDigitada, contador, 1))

               escreval ("caractere original: ",contador1," -> código Criptografado: ", codigo + 2)
               escreval ("")

            fimpara

            para contador2 <- 1 ate compr(valorEmviado) faca
               codigo0 <- asc(copia(valorEmviado, contador2, 1))
            fimpara
            //validando se o usuario digitor so numero
            se (codigo0 < 48) ou (codigo0 > 57) entao

               escreval ("ERRO! Você digito letra.")
               erroSenha <- falso
               escreval (" Seu saldo e de: ",saldo)
               escreval ("Deseja Realiza Nova Transação Via Pix?")
               escreval ("Digiti [SIM] Para fazer nova transferencia.")
               escreval ("Digiti [NÃO] para Sair.")
               leia (novaTransferencia)

            senao

               //validando se o valor digitado pelo usuario é menor que o saldo
               valorEmviado0 <- caracpnum(valorEmviado)

               se(valorEmviado0 > saldo) entao
                  escreval("Saldo insuficiente para essa transação")
                  escreval (" Seu saldo é de: ",saldo)
                  escreval ("Deseja Realiza Nova Transação Via Pix?")
                  escreval ("Digiti [SIM] Para fazer nova transferencia.")
                  escreval ("Digiti [NÃO] para Sair.")
                  leia (novaTransferencia)

               senao

                  //se o valor for meno que o saldo val confima a transferencia
                  linhaSeparacao()
                  escreval ("Transação Efetuada Com Sucesso")
                  linhaSeparacao()
                  escreval (pessoaReceber," Recebeu o Valor")
                  escreval ("")
                  escreval ( "R$ ",valorEmviado0)
                  escreval ("")
                  escreval ("Enviado por: ",nomeUsuario)
                  linhaSeparacao()
                  saldo <- saldo - valorEmviado0
                  escreval ("O Seu Saldo é: ",saldo)
                  linhaSeparacao()
                  escreval ("Deseja Realiza Nova Transação Via Pix?")
                  escreval ("Digiti [SIM] Para fazer nova transferencia.")
                  escreval ("Digiti [NÃO] para Sair.")
                  leia (novaTransferencia)

               fimse
            fimse


         fimse

         novaTransferencia <- maiusc(novaTransferencia)

      fimenquanto
   fimse
fimse

fimalgoritmo
