**Documentação**
----

Usuario Admin:

email: admin@email.com<br />
password: 12345678

URL FRONT= https://mighty-lowlands-32432.herokuapp.com/
URL_BACK = https://whispering-wave-20225.herokuapp.com/api/v1

OBS: é necessário esperar um pouco quando for testar, devido ao plano gratuito do heroku
pois o servidor pode estar hibernando.

Observações:
Devido ao tempo livre que tive para o desafio não consegui fazer tudo:
- Endpoint de edição de avaliação não foi feito.
- Endpoint/Página de criação de Managers não foi criada, foquei no objetivo de criar empregados/Avaliações
- Possui somente 1 Manager como informado acima, que foi criado via console
- Não tive tempo de adicionar um template na aplicação do Front
- Faltou alguns tratamentos de errors em certos endpoints
- Não adicionei paginação nas listagens
- Não utilizei Redux no front, nem troquei o useState para o useReducer quando era necessário


**API**
----

`METHOD` | `URL` | `PARAMS`

**Session**
----

* **Sign In**

  `POST` | `/api/v1/:namespace/sign_in`<br />

  * **Required Params**
  ```
    {
      login: {
        email: 'admin-email',
        password: 'senha'
      }
    }
  ```
  * **Response**
  ```
    {
      success: true,
      auth_token: 'seu-token-para-fazer-requests',
      namespace: 'namespace atual(employees || managers)'
    }
  ```

----

* **Sign Out**

  `DELETE` | `/api/v1/:namespace/sign_out`<br />

  * **Required Headers**
  ```
    {
      'Authorization': 'Bearer ${token-obtido-no-sign-in}'
    }
  ```

  * **Response**
  ```
    { }
  ```

----

**Employees**
----

  * **Required Headers**
  ```
    {
      'Authorization': 'Bearer ${token-obtido-no-sign-in}'
    }
  ```

* **Index**

  `GET` | `/api/v1/managers/employees`<br />

----

* **Show**

  `GET` | `/api/v1/managers/employees/:id`<br />

----

* **Create**

  `POST` | `/api/v1/managers/employees`<br />

  * **Required Params**
  ```
    {
      employee: {
        name: 'nome'|String,
        email: 'email'|String,
        password: 'senha'|String,
        password_confirmation: 'senha'|String
      }
    }
  ```

----

* **Update**

  `PUT` | `/api/v1/managers/employees/:id`<br />

  * **Required Params**
  ```
    {
      employee: {
        name: 'nome'|String,
        email: 'email'|String,
        password: 'senha'|String,
        password_confirmation: 'senha'|String
      }
    }
  ```
----

* **Destroy**

  `DELETE` | `/api/v1/managers/employees/:id`<br />

----



**Avaliations**
----

  * **Required Headers**
    ```
      {
        'Authorization': 'Bearer ${token-obtido-no-sign-in}'
      }
    ```

* **Index**

  `GET` | `/api/v1/:namespace/avaliations`<br />

----

* **Show**

  `GET` | `/api/v1/managers/avaliations/:id`<br />

----

* **Create**

  `POST` | `/api/v1/managers/avaliations`<br />

  * **Required Params**
  ```
    {
      avaliation: {
        employee_id: '42|Integer',
        grade: 9|Integer,
        comment: 'comentario'|String,
      }
    }
  ```

----

* **Destroy**

  `DELETE` | `/api/v1/managers/avaliations/:id`<br />

----

**Resposta Bonus 2**
Para resolver esse problema, utilizaria do Sidekiq e Redis
- Criaria uma fila de request para que possam ser executados assincronamente
- A cada request de venda, adiciona um worker na fila de request, que vão sendo executados conforme o servidor comportar
- Como o relatório não é feito a todo momento, há tempo para que toda a fila seja processada antes da geração do relatório
- Essa fila pode ter uma prioridade baixa, para que não atrapalhe as outras requests do sistema

# Desafio desenvolvedor Repassa

Essa é um desafio da entrevista de desenvolvedor Full Stack Repassa. Você pode dar "fork" nesse projeto, porém,
pedidos de "Pull Request" serão ignorados.

## Requisitos

Crie um aplicativo da Web que permita que um gerente possa enviar uma avaliação para um funcionário e ele consiga ver como está sua avaliação. O ideal é que um funcionário só possa ver a sua avaliação.

*Soluções parcialmente implementadas são aceitas.* Não é obrigatório enviar a solução completa de todos os requisitos, mas o que for enviado necessáriamente precisa estar funcionando.

## Ambiente Admin
* Adicionar/Remover/Atualizar/Ver Empregados
* Adicionar/Remover/Atualizar/Ver Avaliações de Desempenho

## Ambiente Funcionário
* Ver as revisões de desempenho que recebeu

## Escopo do Desafio
* API Backend
  * Você pode fazer em NodeJS ou Ruby.

* Aplicativo Web (frontend)
  * Implementação do frontend usando uma estrutura moderna da web (por exemplo, React, Angular ou VueJS) que fala com o lado do servidor;
  * Layout das telas utilizando é livre (dê preferência utilizando webcomponents);
  * Essa parte deve se interagir com a sua API.

## Como completar este desafio
* Soluções completas são importantes, mas não obrigatórias, porém, o que você enviar precisa estar 100% funcionando.
* Crie a aplicação e codifique como definido acima com o melhor do seu conhecimento/habilidades;
* Coloque comentários no seu código para explicar alguma ação, quando apropriado. Deixe seu código o mais legível possível;
* *Bonus 1*: Escrever testes, pelo menos da API backend (pelo menos de modelos ou controller se houver);
* Você pode enviar o resultado por email compactado no formato: fullstack_[NOME].zip

## O que estamos procurando com esse teste?
* Entender como você faz escolhas com um número limitado de requerimentos;
* Tecnologia e arquitetura escolhidos;
* Identificar seus pontos fortes;
* Este não é um teste eliminatório, porém, poderá servir como material para uma próxima etapa no processo de contratação.

## Bonus 2 (Resposta opcional):

Considerando o seguinte cenário:

1- A cada venda realizada através de uma loja virtual, será enviado pelo portal, através de uma requisição RESTFul (POST), um evento para um novo sistema que deverá ser construido, este evento conterá o id do usuário e valor total do pedido.

2- Como usuário interno desejo ter um relatório onde poderei analisar dados consolidados sobre esses eventos. São eles: Quantidade de vendas e soma total das vendas.

3- Após o desenvolvimento de uma arquitetura convencional, isto é, cada requisição pega uma conexão com o pool de conexões com banco de dados (Postgres) e grava 1 registro. O servidor que foi disponibilizado suportou 1000 requisições por minuto.

4- Entretanto, atualmente a loja faz 1500 vendas por minuto.

Diante da arquitetura convencional descrita no cenário acima, como você melhoraria ou desenharia uma arquitetura para suportar as 1500 requisições por minuto (sem a necessidade de aumentar a infra-estrutura de servidores)?

