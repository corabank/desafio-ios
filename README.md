<div align="center">

  <img src="https://user-images.githubusercontent.com/55195343/153007587-318033ab-05d7-402a-b2aa-2a1ec0f69717.png" width="100" height="100">

# Desafio iOS - Erik Santos

 </div>
 
Este Desafio foi desenvolvido com foco na organização e flexibilidade da arquitetura, destacando as diferenças entre o VIP-C (Clean Swift) e o MVVM-C (Model-View-ViewModel-Coordinator), além de demonstrar o impacto de cada uma dessas abordagens no desenvolvimento do aplicativo.

## Organização do Projeto & Arquitetura Modular

O projeto foi estruturado utilizando o XcodeGen para configurar o workspace, dependências, targets e esquemas, proporcionando uma base sólida para o desenvolvimento.

O Desafio é baseada no conceito de MonoRepo, onde múltiplos projetos são gerenciados dentro de um único repositório. Isso proporciona uma visão unificada do código e simplifica a colaboração entre equipes.

Além disso, foram desenvolvidos Targets (Frameworks) dedicados para funcionalidades específicas:

- DesignKit: Contém elementos de design compartilhados, como cores, fontes, estilos de botões, etc., para garantir uma consistência visual em todo o aplicativo.

- NetworkKit: Gerencia todas as operações de rede, incluindo requisições HTTP, autenticação, e tratamento de respostas, promovendo uma separação clara das responsabilidades e facilitando a reutilização do código.

- CoreKit: Provê funcionalidades essenciais do aplicativo, como armazenamento local, manipulação de dados, e lógica de negócios centralizada. Este framework serve como a espinha dorsal do projeto, promovendo a coesão e a reusabilidade do código.


## Arquitetura Utilizada

O projeto adota diferentes arquiteturas para diferentes partes do aplicativo:

VIP-C (Clean Swift): Foi adotado para as telas de onboarding, login e senha, utilizando UIKit. Esta escolha foi motivada pela facilidade em cobrir toda a camada de teste e pelo gerenciamento eficiente dos ciclos do aplicativo por meio de eventos.

MVVM-C (Model-View-ViewModel-Coordinator): Optamos por esta arquitetura para as telas de lista de extratos e detalhes, utilizando SwiftUI. A integração com o SwiftUI proporcionou uma perfeita sintonia, pois a biblioteca é gerenciada através de estados. Nossa ViewModel fica responsável por gerenciar as Wrapped Properties e o estado da view, evitando problemas com a camada Presenter, como ocorreria no VIP-C.

## Observação

Ao flexibilizar as arquiteturas e bibliotecas utilizadas, pudemos evidenciar a facilidade de desenvolvimento e os diferentes impactos que cada abordagem pode ter no projeto.

Sinta-se à vontade para explorar o código-fonte e entender melhor as decisões de arquitetura tomadas durante o desenvolvimento.


## Inicializar o projeto
Antes de inicar o projeto, certifique-se:

**- Xcodegen & SwiftGen instalado**

**- Versão Minima Xcode 15.4**

**- Testes Snapshots acontecem no iPhone 15 Pro - iOS 17.4**


### Passos
1)Entre na raiz do projeto..

2)Com o terminal aberto, rode esse comando: 

(Caso for M1)
 ```
 xcodegen generate && arch -x86_64 pod install && swiftgen config
 ```

(Outros Processadores)
 ```
 xcodegen generate && pod install && swiftgen config
 ```

### Concorrência

Para lidar com a concorrência, adotamos o moderno conceito de async/await e Actors, introduzido no Swift 5.5. Esta abordagem oferece uma melhor performance em comparação com completionsHandler tradicionais e proporciona um gerenciamento mais assertivo de Threads e Processos no sistema operacional.

A utilização de async/await simplifica o código assíncrono, tornando-o mais legível e fácil de manter. Além disso, os Actors fornecem uma maneira segura de lidar com a concorrência, evitando problemas comuns como Race Conditions e Deadlocks.

### Actor CachedHeaderActor

O Actor `CachedHeaderActor` é um tipo de referência que desempenha um papel crucial na gestão do acesso à memória do sistema operacional. Ao contrário das classes tradicionais, este Actor é projetado para garantir a segurança e a consistência dos dados compartilhados em ambientes concorrentes.

Tecnicamente, o `CachedHeaderActor` permite apenas um acesso à variável por Thread, enquanto outras Threads aguardam a conclusão da operação para acessar o Actor novamente. Isso ocorre de forma transparente em segundo plano, o que melhora significativamente a eficiência e a estabilidade do sistema.

### Update Token
Fizemos uso da gestão manual de uma tarefa (Task) do Swift para realizar a atualização do token. No método `updateToken()` da classe `ExtractListViewModel`, empregamos uma abordagem assíncrona (async), garantindo que o processo ocorra automaticamente na thread de background.

Para garantir um controle preciso do fluxo de execução, criamos uma tarefa personalizada chamada `customTask`. Esta tarefa é responsável por verificar se a operação está em andamento ou se foi cancelada. Em caso de logout do usuário, cancelamos essa tarefa, assegurando que não continue executando no sistema operacional.

Este método permite que o processo de atualização do token ocorra de forma assíncrona e controlada, oferecendo maior segurança e confiabilidade na gestão das operações do aplicativo.

### COMPORTAMENTOS EVIDÊNCIAS
**CPU:**
![Alt text](/ImagesREADME/CPU.png)

**THREADS:**
![Alt text](/ImagesREADME/Threads.png)

**MEMORIA:**
![Alt text](/ImagesREADME/Memoria.png)

**Observação:** é importante ressaltar que durante a execução deste método, não foram observados comportamentos anormais no sistema operacional. Não houve indicações de sobrecarga de threads, vazamentos de memória ou outros problemas que possam surgir devido a uma gestão inadequada das operações do sistema. Isso demonstra a eficácia da abordagem adotada na garantia da estabilidade e do bom funcionamento do aplicativo.

## Logs

Para identificar o funcionamento, adicionar "Prints" a cada requisição e update das operações. Seguindo esse padrão:

### Exemplo 01

1) Aqui vemos uma atualização do Token
![Alt text](/ImagesREADME/Token.png)

### Exemplo 02

2) Aqui vemos uma requisição a lista de Extrato, utilizando o Token Atualizado.
![Alt text](/ImagesREADME/Lista+Token.png)