# SkillProof — backend inicial

Base Java 21 + Spring Boot 3.5.12 + PostgreSQL 17 + Flyway.

## Executar com um comando

Requisito: Docker com Docker Compose v2 e acesso à internet para baixar imagens e dependências.

```bash
docker compose up --build
```

O Compose inicia PostgreSQL, espera seu healthcheck e inicia o backend.
Verifique em outro terminal:

```bash
curl http://localhost:8080/actuator/health
```

Resultado esperado: `{"status":"UP"}`. A aplicação inicial não tem página web.

## Desenvolvimento sem container para Java

Requisitos: JDK 21 e Maven 3.9+.

```bash
docker compose up -d postgres
mvn spring-boot:run
```

Não execute as duas formas simultaneamente: ambas usam a porta 8080.

## Migrações

- `V1__create_initial_schema.sql`: oito tabelas, PKs, FKs, índices, checks e triggers de `updated_at`.
- `V2__insert_initial_data.sql`: sete categorias e oito habilidades.
- Flyway executa cada versão uma vez por banco e registra em `flyway_schema_history`.
- Reiniciar mantém os dados. Apagar linhas não faz o Flyway repetir os INSERTs.
- Não edite migrações já executadas; crie `V3__descricao.sql` para alterações.
- Hibernate usa `ddl-auto: validate`. Quando entidades JPA forem adicionadas, validará seus mapeamentos; neste scaffold ainda não há entidades.
- Datas usam `TIMESTAMPTZ`, apropriado para futuras entidades com `Instant`.
- Ordem empatada deve ser resolvida na futura API por `display_order` e ID.

Consultar dados e histórico:

```bash
docker compose exec postgres psql -U skillproof -d skillproof -c 'TABLE skill;'
docker compose exec postgres psql -U skillproof -d skillproof -c 'TABLE flyway_schema_history;'
```

## Dados iniciais e escopo

Níveis de domínio são sugestões, não validação de competência. Revise antes de publicar.
Microsserviços está no catálogo conforme o modelo discutido, mas não há demo ou experiência cadastrada. O catálogo pode orientar aprendizado; a futura interface pública deve apresentar evidências reais.
Não há evidências, empresas, vagas ou perfis fictícios. Não há CRUD, autenticação, frontend ou aplicativo mobile nesta etapa.
`job_skill` descreve requisitos da vaga; `profile_skill` seleciona habilidades mostradas ao recrutador.

## Configuração local

Credenciais padrão são apenas para desenvolvimento. Pode copiar `.env.example` para `.env` e ajustar `DB_PASSWORD` antes da primeira execução. Ao mudar senha depois que o volume existe, alterar a variável não modifica automaticamente a senha do usuário PostgreSQL.
Para Java local, `.env` não é carregado automaticamente pelo Spring: exporte `DB_PASSWORD`, `DB_USERNAME` e `DB_URL` quando necessário.
As portas estão limitadas a localhost. Para publicação futura, configure autenticação administrativa, HTTPS e segredos no ambiente de hospedagem.

Parar preservando os dados:

```bash
docker compose down
```

## Referência

https://docs.spring.io/spring-boot/how-to/data-initialization.html

## Verificação nesta entrega

XML do Maven e arquivos YAML validados; os dois scripts foram analisados pelo parser PostgreSQL (pglast) sem erros de sintaxe. A execução das migrações num PostgreSQL real e a inicialização via Docker não foram realizadas neste ambiente.

O empacotamento Maven também passou com `-Djava.version=17`, usando o JDK disponível no ambiente. O alvo entregue permanece Java 21; não foi validado em JDK 21 aqui.
