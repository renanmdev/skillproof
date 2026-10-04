# SkillProof

**Portfólio técnico com evidências práticas de competências e apresentações personalizadas por vaga.**

O SkillProof é um projeto de Renan Monteiro Silva de Paula para reunir habilidades técnicas, suas evidências e perfis direcionados a oportunidades profissionais. A proposta é permitir que recrutadores explorem competências relevantes para uma vaga e acessem as implementações que sustentam cada uma delas.

Uma habilidade poderá ser associada a projetos, demonstrações, código, artigos, certificações ou experiências profissionais. A origem de cada evidência será identificada para contextualizar o conhecimento apresentado.

## Estado atual

O projeto está na fase inicial de desenvolvimento. A base do backend já inclui:

- Aplicação Spring Boot configurada para Java 21.
- PostgreSQL em container, com persistência em volume.
- Migrações versionadas com Flyway.
- Modelo relacional para habilidades, evidências, empresas, vagas e perfis.
- Catálogo inicial com sete categorias e oito habilidades.
- Endpoint de saúde em `/actuator/health`.
- Docker Compose para iniciar aplicação e banco de dados.

A inicialização local do backend foi confirmada com resposta HTTP `200 OK` e `{"status":"UP"}` no endpoint de saúde. As entidades JPA, os endpoints de negócio, a autenticação e as interfaces web e mobile estão nas próximas etapas.

## Tecnologias utilizadas

| Tecnologia | Aplicação no projeto |
| --- | --- |
| Java 21 | Linguagem do backend |
| Spring Boot 3.5.12 | Inicialização e configuração da aplicação |
| Spring Data JPA / Hibernate | Dependências preparadas para a camada de persistência |
| PostgreSQL 17 | Banco de dados relacional |
| Flyway | Criação e evolução versionada do schema |
| Spring Boot Actuator | Endpoint de saúde |
| Maven | Gerenciamento de dependências e build |
| Docker / Docker Compose | Ambiente local reproduzível |

## Organização do repositório

O repositório concentra os componentes do projeto. Atualmente, o código está em `backend/`; as interfaces web e mobile serão adicionadas conforme o desenvolvimento avançar.

```text
skillproof/
├── README.md
└── backend/
    ├── src/main/
    │   ├── java/com/renan/skillproof/
    │   └── resources/
    │       ├── application.yml
    │       └── db/migration/
    │           ├── V1__create_initial_schema.sql
    │           └── V2__insert_initial_data.sql
    ├── pom.xml
    ├── Dockerfile
    ├── docker-compose.yml
    └── .env.example
```

## Modelo de dados

| Tabela | Responsabilidade |
| --- | --- |
| `skill_category` | Categorias de habilidades |
| `skill` | Catálogo de habilidades técnicas |
| `evidence` | Evidências vinculadas a uma habilidade |
| `company` | Empresas relacionadas às vagas |
| `job` | Vagas e status de acompanhamento |
| `job_skill` | Habilidades solicitadas pela vaga, relevância e obrigatoriedade |
| `profile` | Apresentação personalizada vinculada a uma vaga |
| `profile_skill` | Habilidades selecionadas e ordenadas para a apresentação |

A separação entre `job_skill` e `profile_skill` permite registrar o que a vaga exige e escolher o que destacar no portfólio de forma independente.

O schema inclui chaves primárias e estrangeiras, restrições de unicidade, validações de valores, índices e atualização automática de `updated_at` em habilidades e perfis. Os timestamps usam `TIMESTAMPTZ`.

## Executar localmente

### Com Docker

Requisitos: Docker com Docker Compose v2 e conexão à internet para baixar imagens e dependências.

A partir da raiz do repositório:

```bash
cd backend
docker compose up --build
```

O Compose inicia o PostgreSQL, aguarda o healthcheck do banco e inicia o backend. O Flyway aplica as migrações pendentes durante a inicialização.

Abra no navegador:

http://localhost:8080/actuator/health

Resposta esperada:

```json
{"status":"UP"}
```

Esse endereço verifica a saúde da aplicação; a interface do portfólio ainda será desenvolvida.

### Com Java e Maven locais

Requisitos adicionais: JDK 21 e Maven 3.9 ou superior.

A partir da raiz do repositório:

```bash
cd backend
docker compose up -d postgres
mvn spring-boot:run
```

Escolha uma das formas de executar o backend, pois ambas usam a porta `8080`.

### Consultar o banco

Execute os comandos a seguir dentro de `backend/`:

```bash
docker compose exec postgres psql -U skillproof -d skillproof -c "TABLE skill;"
docker compose exec postgres psql -U skillproof -d skillproof -c "TABLE flyway_schema_history;"
```

O catálogo inicial contém Java, Spring Boot, Angular, TypeScript, PostgreSQL, REST API, Microservices e Docker. Os níveis cadastrados são avaliações iniciais editáveis; a presença no catálogo não indica, por si só, experiência profissional ou uma demonstração concluída. As evidências serão cadastradas conforme forem disponibilizadas.

### Parar os containers

```bash
docker compose down
```

O volume do PostgreSQL preserva os dados entre execuções.

## Versionamento do banco

- `V1__create_initial_schema.sql` cria a estrutura relacional.
- `V2__insert_initial_data.sql` insere categorias e habilidades iniciais.
- Cada migração é executada uma única vez por banco, com registro em `flyway_schema_history`.
- Novas alterações devem ser adicionadas em novas migrações, como `V3__add_skill_fields.sql`, sem modificar scripts já executados.
- Excluir registros não faz o Flyway repetir os dados iniciais.

O Hibernate está configurado com `ddl-auto: validate`. Quando as entidades JPA forem implementadas, seus mapeamentos serão validados contra o schema gerenciado pelo Flyway.

## Configuração do ambiente

A aplicação utiliza as variáveis `DB_URL`, `DB_USERNAME` e `DB_PASSWORD`, com valores padrão para desenvolvimento local. As portas dos containers são expostas apenas em `localhost`.

Para personalizar a senha no Compose, copie `backend/.env.example` para `backend/.env` e ajuste `DB_PASSWORD` antes da primeira inicialização do banco. Alterar essa variável depois da criação do volume não altera automaticamente a senha do usuário PostgreSQL.

Ao executar Java localmente, configure as variáveis no terminal ou na IDE: o Spring Boot não carrega o arquivo `.env` automaticamente. Credenciais reais devem ser fornecidas pelo ambiente de execução e mantidas fora do Git.

## Próximas etapas

- Implementar entidades JPA, repositories, serviços e API REST.
- Criar o gerenciamento de habilidades e evidências.
- Implementar vagas e perfis públicos personalizados.
- Desenvolver a interface web com Angular e o aplicativo mobile.
- Adicionar testes automatizados e integração contínua.
- Construir demonstrações técnicas, incluindo comunicação entre serviços.

A arquitetura atual utiliza uma única aplicação backend. Demonstrações de microsserviços e outras tecnologias serão incorporadas como implementações identificáveis, com documentação e links para o código.

## Autor

**Renan Monteiro Silva de Paula** — Desenvolvedor Full Stack

[Perfil no GitHub](https://github.com/renanmdev) · [Repositório do SkillProof](https://github.com/renanmdev/skillproof)
