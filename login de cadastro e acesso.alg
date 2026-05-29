algoritmo "3 EXECÍCIO DA IA PROFISSIONAL"
var
acesso0 : caractere
agencia, agencia0 : caractere
conta, conta0 : caractere
senha0 : caractere
nomeUsuario : caractere
acesso1, acesso2 : caractere
transferencia, transferenciaMaius, novaTransferencia :caractere
contador4, tentaNovamente, tentaNovamente2: caractere


agencia1, conta1, senha, contador0, senha1, senha2, contador3, codigo1 : inteiro



erroSenha, erro, erro1, erro2, passa: logico

saldo : real

//ária criptografada de transferência ------------------------------
pessoaReceber, senhaDigitada, valorEmviado, contador1 :caractere

contador, contador2, codigo, codigo0 :inteiro

valorEmviado0 : real

procedimento linhaSeparacao()
inicio
escreval ("-----------------------------------------------------")

fimprocedimento
inicio

procedimento tentarNovamente()
inicio
escreval ("     Digite [SIM] para tenta novamenter ")
escreval ("")
escreval ("     Digite [NÃO] para Sair    ")
fimprocedimento
//inicializa as variáves para fazer a primeira comparação do enquanto
//e derfinir o login de acesso para o usuária
nomeUsuario <- "Weriton"
agencia <- "0001"
conta <- "12345"
senha <- 2026
saldo <- 1250
agencia0 <- ""
conta0 <- ""
senha2 <- 0
// começando o tentanovamente como SIM para poder entra no enquanto
tentaNovamente <- "SIM"

enquanto (tentaNovamente = "SIM") e ((agencia <> agencia0) ou (conta <> conta0) ou ( senha <> senha2)) faca

   //reseta as variáveis para não entrar com loop infinito
   erro <- falso
   erro1 <- falso
   erro2 <- falso
   passa <- falso
   linhaSeparacao()
   escreval ("         Bem-Vindo ao Nubank        ")
   linhaSeparacao()
   escreval ("")
   escreval ("  Digite [1] Para Acessar Sua Conta  ")
   escreval ("")
   escreval ("  Digite [2] Para se Cadastrar    ")
   leia(acesso0)

   //primeira area de acesso
   se (acesso0 = "1") entao

      //repetição de segurança com [enquanto]
      limpatela
      linhaSeparacao()
      escreval ("    Digite o Número da Sua Agência  ")
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

      //validando o acesso da conta se digitou só número e transforma em [asc] linguagem do computador
      para contador0 <- 1 ate compr(conta0) faca
         conta1 <- asc (copia(conta0, contador0, 1))
         se (conta1 < 48) ou (conta1 > 57) entao
            erro1 <- verdadeiro
         senao
            passa <- verdadeiro
         fimse
      fimpara

      //validando o acesso da senha se digitou so número e transforma em [asc] linguagem do computador
      para contador0 <- 1 ate compr(senha0) faca
         senha1 <- asc(copia(senha0, contador0, 1))
         se (senha1 < 48) ou (senha1 > 57) entao
            erro2 <- verdadeiro
         senao

            passa <- verdadeiro
         fimse

      fimpara

      // validação completa da senha e transformando de caractere para número em segurança a senha  completo
      se (erro2 = falso) entao

         senha2 <- caracpnum(senha0)

      fimse

      // validado se o usuário nao digitou letras e a quantedadi de digito certo separadamente para exibir onde
      //realmente o campo que esta errado
      se (erro = verdadeiro) ou (compr(agencia0) <> 4)entao

         escreval ("ERRO! Número da agência inválida.")

      fimse

      se (erro1 = verdadeiro) ou (compr(conta0) <> 5) entao

         escreval ("ERRO! Número da conta inválida")

      fimse

      se (erro2 = verdadeiro) ou (compr(senha0) <> 4) entao

         escreval ("ERRO! Senha inválida")
      fimse

      //se o usuário errar mostra a opção de tentar novamente
      se (agencia = agencia0) e (conta = conta0) e ( senha = senha2) entao

         //para da a boas-vindas a usuário
         limpatela
         linhaSeparacao()
         escreval ("Login efetuado com sucesso")
         linhaSeparacao()

      senao
         linhaseparacao()
         escreval ("Dados incorretos ou inválidos!")
         linhaSeparacao()
         escreval ("Gostaria de tenta novamenter")
         tentarNovamente()
         leia (tentaNovamente)
      fimse

   senao
      //para não fechar o programa se o usuário escolher a opção errada e fazer ele tentar novamente
      escreval ("Opção inválida!")
      linhaSeparacao()
      escreval ("Gostaria de tentar novamenter")
      linhaSeparacao()
      tentarNovamente()
      leia (tentaNovamente)
      tentaNovamente <- maiusc(tentaNovamente)
   fimse
   // para  transformar tudo em maiúsculo para facilitar o que o usuário digitou
   tentaNovamente <- maiusc(tentaNovamente)

fimenquanto

// validando agencia, conta e senha
// e laço de repetição para que validar qualquer tipo de erro
tentaNovamente2 <- "SIM"
enquanto (tentaNovamente2 = "SIM") faca
   se (agencia = agencia0) e (conta = conta0) e ( senha = senha2) entao
      limpatela
      linhaSeparacao()
      escreval ("      Bem-Vindo a Sua Conta      ")
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

         //colocando a mesma opção do acesso2 no acesso1 para ter a mesma saida
         //pois se o usuário vim do acesso1 para ver o saldo colocamos a variável
         //acesso1 para fica igual para não da erro.
         // aqui onde acontece a magica tudo que for colocado na área acesso2
         // e como é transferida para o acesso1.
         se (acesso2 = "1") entao

            acesso1 <- "2"

         senao

            acesso1 <- "3"

         fimse
      fimse

      // acesso para area pix tanto no primeiro acesso ou apois o saldo
      se (acesso1 = "2") entao

         limpatela
         linhaSeparacao()
         escreval ("     Olá! Bem Vindo Aria a Pix  ")
         linhaSeparacao()
         escreval ("     Com base no seu saldo atual   ")
         escreval ("           De: R$ ",saldo         )
         linhaSeparacao()
         escreval ("     Para Fazer Transação Via Pix  ")
         linhaSeparacao()
         escreval ("     Digite [SIM] para uma Transferecia ")
         escreval ("")
         escreval ("     Digite [NÃO] para Sair    ")
         leia (transferencia)


         // transformando em maiusculo para acessa a area pix
         transferenciaMaius <- maiusc(transferencia)

         se (transferenciaMaius = "SIM") entao
            //para quebra o laço do enquanto e ir para área de transferencia
            tentaNovamente2 <- "NAO"
         senao
            se (transferenciaMaius = "NAO") ou (transferenciaMaius = "NÃo") entao
               // para ir direto para a ária de fechar o programa
               acesso1 <- "3"

            senao

               linhaSeparacao()
               escreval ("Opção inválida!")
               linhaSeparacao()
               escreval ("Gostaria de tentar novamente?")
               linhaSeparacao()
               tentaNovamente2()
               leia(tentaNovamente2)
               tentaNovamente2 <- maiusc(tentaNovamente2)
            fimse
         fimse
      fimse

      //area de fechamento do programa
      se (acesso1 = "3") entao
      
         escreval("Saindo da conta. Até logo!")
         tentaNovamente2 <- "NAO"
         
      fimse
      
      //area de segurança. tudo que vinher do acesso1 diferente disso cai nesse bloco de validação de erro
      se (acesso1 <> "1") e (acesso1 <> "2") e (acesso1 <> "3") entao
      
        linhaSeparacao()
        escreval ("Opção inválida!")
        linhaSeparacao()
        tentaNovamente
        leia(tentaNovamente2)
        tentaNovamente2 <- maiusc(tentaNovamente2)
      fimse
   fimse
fimenquanto
// acesso area de transferencia de pix
se (transferenciaMaius = "SIM") entao

   novaTransferencia <- "SIM"

   enquanto ((saldo > 0) e (novaTransferencia = "SIM")) faca



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


fimalgoritmo
