**Documentação**
----

Usuario Admin:

email: admin@email.com<br />
password: 12345678

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

  `POST` | `/api/v1/:namespace/sign_out`<br />

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

* **Messages**

    `GET` | `/messages`<br />
    example: curl 'https://agendamail.herokuapp.com/api/v1/messages?token=XXX'

* **Create Message**

  `POST` | `/messages` | `message[title]=string&message[content]=string`<br />
  example: curl -X POST 'https://agendamail.herokuapp.com/api/v1/messages' -d 'message[receiver_email]=matheus@email.com&message[title]=APITEST&message[content]=CONTEUDO&token=XXX'

* **Sent**

    `GET` | `/messages/sent`<br />
    example: curl 'https://agendamail.herokuapp.com/api/v1/messages/sent?token=XXX'

* **Archived**

  `GET` | `/messages/archived` | `permision=master`<br />
  example: curl 'https://agendamail.herokuapp.com/api/v1/messages/archived?token=XXXX&permission=master'

* **Show Message**

  `GET` | `/messages/:id`<br />
  example: curl 'https://agendamail.herokuapp.com/api/v1/messages/1?token=XXX'<br />
  OR curl 'https://agendamail.herokuapp.com/api/v1/messages/1?token=XXX&permission=master'

* **Archive Message**

  `PATCH` | `/messages/:id/archive`<br />
  example: curl -X PATCH 'https://agendamail.herokuapp.com/api/v1/messages/1/archive?token=XXX'

* **Archive Multiples**

  `GET` | `/messages/archive_multiple` | `message_ids[]`<br />
  example: curl -g -X PATCH 'https://agendamail.herokuapp.com/api/v1/messages/archive_multiple?token=XXX&message_ids[]=1&message_ids[]=2'

----

* **Users**

  `GET` | `/users` | `permision=master`<br />
  example: curl 'https://agendamail.herokuapp.com/api/v1/users?token=XXX&permission=master'

* **User Messages*

  `GET` | `/users/:id/messages` | `permision=master`<br />
  curl 'https://agendamail.herokuapp.com/api/v1/users/1/messages?token=XXX&permission=master'

* **Update Profile**

  `PATCH` | `/users/:id` | `user[name]=string&user[email]=string&user[password]=string&user[password_confirmation]=string`<br />
  example: curl -g -X PATCH 'https://agendamail.herokuapp.com/api/v1/users/1?token=XXX&user[name]=Mateus'

----
**Clone**
Dowload the project and then

```
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

Create a `config/application.yml'

```
development:
  api_key: XXXX
```
**Test**

`bundle exec rspec`

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

