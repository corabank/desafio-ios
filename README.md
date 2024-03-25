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

**- Xcodegen SwiftGen instalado**

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