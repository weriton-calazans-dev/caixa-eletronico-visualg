# ?? Sistema de Caixa Eletrônico (VisuAlg)

Este é um algoritmo desenvolvido em Portugol (ambiente VisuAlg 3.0) que simula as operações reais de um Caixa Eletrônico bancário. O projeto conta com controle de múltiplos usuários, validações rígidas de segurança e exibição de histórico de transações.

---

## ?? Funcionalidades Implementadas

*   **Cadastro Automatizado:** Criação de conta com geração automática do número da conta e validação de agência.
*   **Validações Inteligentes:**
    *   Bloqueio de números e caracteres especiais no campo de Nome (via varredura de strings).
    *   Bloqueio de letras e validação de tamanho de 4 dígitos para a Senha (via tabela ASCII).
*   **Algoritmo de Ordenação:** Uso de *Insertion Sort* para organizar as contas cadastradas por ordem alfabética no vetor.
*   **Menu de Operações:**
    *   `[1] Ver Saldo` com formatação monetária.
    *   `[2] Depósito` com tratamento de erro para valores inválidos.
    *   `[3] Transferência (Pix)` com checagem de saldo e validação de senha do remetente.
    *   `[4] Extrato de Saídas` permitindo ordenar as transferências do **mais recente para o mais antigo** (usando algoritmo de inversão de vetor) ou vice-versa.

---

## ??? Conceitos de Lógica Utilizados

*   **Estruturas de Dados:** Vetores (Arrays) para gerenciar nomes, contas, senhas, saldos e históricos.
*   **Modularização:** Uso de Funções com retorno (`validaLetras`, `validaNumero`) e Procedimentos (`organizarVetor`, `inverte`, `validaSim`).
*   **Algoritmos Clássicos:** Ordenação por Inserção (*Insertion Sort*) e inversão de posições usando técnica de ponteiros (Esquerda/Direita).

---

## ?? Como Executar

1. Baixe e instale o **VisuAlg 3.0** (ou superior).
2. Clone este repositório ou copie o código do arquivo `.alg`.
3. Abra o arquivo no VisuAlg.
4. Pressione `F9` para rodar e testar as operações no console.

---

## Autor

*   **Weriton Calazans de Moraes** - [GitHub](https://github.com/weriton-calazans-dev)
