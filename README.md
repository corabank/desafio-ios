<div align="center">

  <img src="https://user-images.githubusercontent.com/55195343/153007587-318033ab-05d7-402a-b2aa-2a1ec0f69717.png" width="100" height="100">

# Desafio iOS

 </div>
 
 > Para participar, basta criar um fork deste repositório e quando finalizar o desenvolvimento, abrir um merge request que iremos avaliar.

O desafio consiste em implementar dois fluxos simples de tela, sendo um de autenticação e um de lista + detalhes.

O layout pode ser acessado [aqui](https://www.figma.com/file/mfScPv5hxIqg25obhaHNNB/SR?type=design&node-id=0%3A1&mode=dev&t=aqdh9RprKrYpateD-1)

## Requisitos
- View Code
- Não utilizar libs externas
- Teste unitário

### Aqui iremos avaliar:
- Atenção aos casos de uso
- Organização do projeto
- Organização de código
- Boas práticas de desenvolvimento
- Definição da arquitetura e utilização de Design Patterns
- Aplicação dos conceitos de SOLID
- Conhecimento dos recursos nativos para estruturação de UI, acesso a dados (local e remoto) e concorrência

### Bonus (opcional)
- SwiftUI
- XCUITest
- Arquitetura modular
- Documentação

## Casos de uso
### Login
- No passo de CPF, habilitar o botão apenas se digitar um CPF válido
- No passo de senha, habilitar o botão apenas se a senha tiver 6 dígitos

No passo de senha, ao tocar no botão "Próximo", é preciso fazer a request:

```
POST https://api.challenge.stage.cora.com.br/challenge/auth
-- header 'apikey: {{API_KEY}}'
{
  "cpf": "{{CPF}}",
  "password": "{{SENHA}}"
}
```

Caso os dados estejam corretos, a request irá retornar:

```
200 https://api.challenge.stage.cora.com.br/challenge/auth
{
    "token": "{{TOKEN}}"
}
```
> Será necessário armazenar o token recebido para ser utilizado depois

Caso os dados estejam incorretos, o retorno será:

```
401 https://api.challenge.stage.cora.com.br/challenge/auth
```

### Token
O Token possui uma validade de 1 minuto. Então a cada 1 minuto é necessário fazer a request de autenticação novamente, mas dessa vez enviando o token antigo:
> Importante garantir uma boa gestão de concorrência para evitar que outra request seja feita enquanto o token estiver sendo atualizado.

```
POST https://api.challenge.stage.cora.com.br/challenge/auth
-- header 'apikey: {{API_KEY}}'
{
  "token": "{{TOKEN}}"
}
```

Caso o token seja validado corretamente, a request irá retornar um novo token:

```
200 https://api.challenge.stage.cora.com.br/challenge/auth
{
    "token": "{{TOKEN}}"
}
```

Caso o token não seja validado, o retorno será:

```
401 https://api.challenge.stage.cora.com.br/challenge/auth
```

### Lista
- Deverá exibir um placeholder enquanto a request estiver sendo feita
- Deverá implementar um *pull to refresh*

Pra trazer os dados da lista, será necessário fazer a request:

```
GET https://api.challenge.stage.cora.com.br/challenge/list
-- header 'apikey: {{API_KEY}}'
-- header 'token: {{TOKEN}}'
```
Caso seja um token válido, a request irá retornar:

```
200 https://api.challenge.stage.cora.com.br/challenge/list
{
  "results": [
    {
      "items": [
        {
          "id": "abc123def456ghi789",
          "description": "Compra de produtos eletrônicos",
          "label": "Compra aprovada",
          "entry": "DEBIT",
          "amount": 150000,
          "name": "João da Silva",
          "dateEvent": "2024-02-01T08:15:17Z",
          "status": "COMPLETED"
        }
      ],
      "date": "2024-02-01"
    }
  ],
  "itemsTotal": 1
}
```
Caso o token não seja válido, o retorno será: 

```
401 https://api.challenge.stage.cora.com.br/challenge/list
```

### Detalhes
- Deverá exibir um placeholder enquanto a request estiver sendo feita

Pra trazer os detalhes de um item, será necessário fazer a request:

```
GET https://api.challenge.stage.cora.com.br/challenge/details/:id
-- header 'apikey: {{API_KEY}}'
-- header 'token: {{TOKEN}}'
```

Caso seja um token válido, a request irá retornar:

```
200 https://api.challenge.stage.cora.com.br/challenge/details/:id
{
  "description": "Pagamento por serviços prestados",
  "label": "Pagamento recebido",
  "amount": 150000,
  "counterPartyName": "Empresa ABC LTDA",
  "id": "abcdef12-3456-7890-abcd-ef1234567890",
  "dateEvent": "2024-02-05T14:30:45Z",
  "recipient": {
    "bankName": "Banco XYZ",
    "bankNumber": "001",
    "documentNumber": "11223344000155",
    "documentType": "CNPJ",
    "accountNumberDigit": "9",
    "agencyNumberDigit": "7",
    "agencyNumber": "1234",
    "name": "Empresa ABC LTDA",
    "accountNumber": "987654"
  },
  "sender": {
    "bankName": "Banco ABC",
    "bankNumber": "002",
    "documentNumber": "99887766000112",
    "documentType": "CNPJ",
    "accountNumberDigit": "3",
    "agencyNumberDigit": "1",
    "agencyNumber": "5678",
    "name": "Empresa XYZ LTDA",
    "accountNumber": "543210"
  },
  "status": "COMPLETED"
}
```

Caso o token não seja válido, o retorno será: 

```
401 https://api.challenge.stage.cora.com.br/challenge/details/:id
```
