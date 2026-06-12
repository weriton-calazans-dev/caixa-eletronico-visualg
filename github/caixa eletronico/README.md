** Caixa Eletrônico Multi-Usuário em VisuAlg  **

- Este projeto consiste em um **Simulador de Caixa Eletrônico Comercial** totalmente funcional, desenvolvido em VisuAlg 3.0 (Portugol). O sistema emula as principais operações de um banco real, suportando múltiplos clientes simultâneos, isolamento de dados de transações e relatórios de extrato personalizáveis.

- O grande diferencial deste projeto é a implementação de arquiteturas complexas de algoritmos e controle de memória linear dentro de um ambiente de desenvolvimento puramente estruturado.

--- Funcionalidades Principais ?

- **Banco Multi-Usuário (Até 5 Clientes):** Cadastro de novas contas em tempo de execução com geração sequencial automatizada e proteção contra inputs duplicados.
- **Autenticação Segura:** Módulo de login robusto cruzando dados paralelos (Nome, Agência, Conta e Senha).
- **Módulo Financeiro Completo:**
- Depósito imediato com logs automáticos.
- Transferências entre clientes do próprio banco (PIX) com busca de chaves em tempo real e atualização de ambos os saldos.
- Saque em espécie com validações de consistência lógica (checagem de fundos e senhas).
- **Histórico e Extratos Bidimensionais:** Consulta de fluxos de caixa de créditos e débitos, permitindo ordenação cronológica natural ou reversa (do mais recente para o mais antigo).

--- Soluções de Engenharia e Complexidade Aplicada ?

Para contornar as limitações nativas do ambiente VisuAlg, foram adotadas as seguintes estratégias de lógica de programação:

1. **Matrizes Paralelas Relacionais:** O histórico de transações é gerenciado por matrizes bidimensionais do tipo `vetor [1..5, 1..5]`. A primeira dimensão atua como uma chave estrangeira implícita correspondente ao índice do usuário autenticado, blindando a visualização de dados de terceiros.
2. **Ordenação de Vetores Simultâneos (Insertion Sort):** O programa inclui um algoritmo de ordenação por inserção automática. Toda vez que um cliente é cadastrado, a base de dados de nomes é colocada em ordem alfabética, deslocando dinamicamente os índices correspondentes nos vetores de senhas, saldos e matrizes de extrato para manter o sincronismo operacional.
3. **Validação Sanitizada via Tabela ASCII:** As funções `validaLetras` e `validaNumero` barram tentativas de inserção de dados espúrios ou quebras de tipo no terminal, inspecionando os códigos inteiros decimais da tabela ASCII (por exemplo, exigindo caracteres estritamente entre `48` e `57` para dados monetários).
4. **Algoritmo de Dois Ponteiros (Two Pointers):** Implementado no procedimento `inverte` para realizar a inversão das colunas da matriz de transações em tempo de execução (Complexidade $O(N)$), otimizando a memória ao renderizar o extrato invertido sem a necessidade de duplicar vetores.

--- Tecnologias ?

- **Linguagem:** Portugol / Lógica Estruturada
- **IDE:** VisuAlg 3.0

--- Como Rodar o Projeto ?

1. Baixe o executável do [VisuAlg 3.0](https://visualg30.sourceforge.io/).
2. Faça o clone deste repositório ou copie o código contido no arquivo `caixa_eletronico.alg`.
3. Abra o arquivo na interface do VisuAlg.
4. Pressione a tecla `F9` para rodar e testar o ecossistema bancário.

--- **Autor**
Desenvolvido com foco em lógica de programação avançada por **Weriton Calazans de Moraes**
 
              [GitHub](https://github.com/weriton-calazans-dev)
