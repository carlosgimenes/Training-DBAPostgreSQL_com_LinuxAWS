# DBA PostgreSQL com Linux AWS CentOS, Red Hat, Debian

## Requisitos observados para vagas de DBA PostgreSQL

### 27/11/2024 - Vaga anunciada no Linkedin

- Empresa: **AL Consultoria Tech**
- Vaga: **DBA Postgre Sênior**

#### Responsabilidades Da Posição

- Instalação e Configuração: Capacidade de instalar, configurar e atualizar o PostgreSQL, incluindo a definição de parâmetros de configuração apropriados para otimização de desempenho e segurança.
- Monitoramento e Otimização: Habilidade em monitorar o desempenho do banco de dados, identificar gargalos e otimizar consultas usando índices, estatísticas e ajustes de configuração.
- Backup e Restauração: Conhecimento em estratégias de backup e recuperação, incluindo backups regulares, backups incrementais, backups lógicos e físicos, e a habilidade de restaurar bancos de dados em caso de falhas.
- Segurança: Compreensão profunda das práticas de segurança, incluindo a implementação de autenticação, autorização, criptografia, proteção contra ataques e vulnerabilidades.

#### Requisitos Obrigatórios Para a Posição

- Replicação e Alta Disponibilidade: domínio nas ferramentas de gerenciamento de banco de dados da Amazon (RDS: Replicação de Banco, Snapshot, Backup e restore e Multi-AZ).
- Migração de Dados: Capacidade de migrar dados de outros sistemas de gerenciamento de banco de dados (DBMS) para o PostgreSQL e vice-versa.
- Versionamento e Controle de Esquema: Conhecimento em ferramentas e práticas para gerenciar as mudanças de esquema do banco de dados, garantindo a integridade dos dados e a compatibilidade entre as versões.
- Programação e Desenvolvimento: Habilidade em escrever e otimizar consultas SQL complexas, além de conhecimento em PL/pgSQL ou outras linguagens de programação utilizadas para funções armazenadas.
- Ferramentas de Administração: Familiaridade com ferramentas de administração e monitoramento de terceiros, como pgAdmin, pgBadger, pgbouncer, entre outras.
- Manutenção e Atualização: Capacidade de aplicar patches de segurança e atualizações do PostgreSQL, mantendo o sistema atualizado e seguro.

Com base nestes requisitos, solicitei ao ChatGPT fazer um resumo com sugestão de um roteiro de estudo, que apresento a seguir.

**ChatGPT**

```text
Bom dia! Para atender aos requisitos da vaga e se preparar para trabalhar como DBA PostgreSQL, aqui está um roteiro de estudos estruturado por tópicos e fases:
```

---

### **Fase 1: Fundamentos do PostgreSQL**

1. **Introdução ao PostgreSQL:**
   - Instalação e configuração inicial em diferentes sistemas operacionais.
   - Configuração básica de parâmetros (memory, connection, logging).
   - Ferramentas administrativas: pgAdmin e linha de comando (`psql`).

2. **Estrutura de Dados e SQL:**
   - Criação de tabelas, índices e relações (chaves primárias, estrangeiras).
   - Consultas SQL básicas e complexas, incluindo `JOIN`, `GROUP BY`, subconsultas e funções de agregação.
   - Linguagem PL/pgSQL para criação de funções armazenadas e triggers.

---

### **Fase 2: Administração e Monitoramento**

1. **Configuração e Otimização:**
   - Ajustes nos parâmetros de desempenho (work_mem, shared_buffers, etc.).
   - Uso de ferramentas como `pgBadger` e `pg_stat_activity` para monitoramento.
   - Implementação de índices apropriados (B-Tree, Hash, GIN, GIST).

2. **Segurança e Permissões:**
   - Configuração de autenticação e autorização (roles e privilégios).
   - Criptografia de dados em repouso e em trânsito.
   - Proteção contra ataques comuns (SQL Injection, brute force).

3. **Backup e Restauração:**
   - Métodos de backup lógico (`pg_dump`) e físico (`pg_basebackup`).
   - Configuração de backups incrementais e scripts automatizados.
   - Restauração em diferentes cenários (acidentes, migração).

---

### **Fase 3: Recursos Avançados**

1. **Replicação e Alta Disponibilidade:**
   - Configuração de replicação streaming e lógica.
   - Implementação de cenários Multi-AZ no Amazon RDS.
   - Gerenciamento de snapshots e failover automático.

2. **Migração de Dados:**
   - Ferramentas para migração: `pgloader`, `pg_dump`, `pg_restore`.
   - Estratégias para migração de grandes volumes de dados.
   - Comparação de esquemas e validação pós-migração.

3. **Versionamento e Controle de Esquema:**
   - Gerenciamento de mudanças de esquema com ferramentas como Flyway ou Liquibase.
   - Controle de versionamento em bancos com múltiplos ambientes (dev, staging, produção).

---

### **Fase 4: Especialização e Amazon RDS**

1. **Amazon RDS com PostgreSQL:**
   - Configuração de instâncias RDS e parâmetros otimizados.
   - Gerenciamento de backups, snapshots e replicação.
   - Monitoramento com o Amazon CloudWatch e integração com outras ferramentas.

2. **Ferramentas de Administração:**
    - Uso de `pgBadger` para análises detalhadas de desempenho.
    - Configuração do `pgBouncer` para pooling de conexões.

3. **Manutenção e Atualizações:**
    - Planejamento de patches e upgrades do PostgreSQL.
    - Teste de atualizações em ambientes de homologação.

---

### **Dicas Adicionais**

- **Prática em Laboratório:** Monte um ambiente de teste em uma máquina virtual ou na nuvem para replicar cenários reais.
- **Estudo de Casos:** Analise situações práticas em fóruns e blogs, como o PostgreSQL Wiki e a comunidade oficial.
- **Certificações:** Considere estudar para certificações PostgreSQL ou AWS para fortalecer seu perfil.

---

Pedi para que detalhasse a Fase 1, a seguir a recomendação que ele fez.

**ChatGPT**

```text
Ótima escolha! Vamos detalhar a **Fase 1** com foco nos fundamentos do PostgreSQL:
```

---

### Fase 1: Fundamentos do PostgreSQL

#### 1. **Introdução ao PostgreSQL**
**Objetivos:**
- Compreender o funcionamento básico do PostgreSQL.
- Instalar e configurar o ambiente para estudos.

**Atividades e Recursos:**

- **Instalação:**
  - **Linux:** Use `apt` ou `yum` para instalar. Teste com comandos:

    ```bash
    sudo apt update
    sudo apt install postgresql postgresql-contrib
    sudo systemctl start postgresql
    ```

  - **Windows:** Baixe e instale do site oficial ([PostgreSQL Downloads](https://www.postgresql.org/download/)).

  - **Docker:** Crie um container PostgreSQL:

    ```bash
    docker run --name postgres-lab -e POSTGRES_PASSWORD=senha123 -p 5432:5432 -d postgres
    ```

- **Configuração Inicial:**
  - Acesse o PostgreSQL usando `psql`.
  - Configure parâmetros básicos como `max_connections` e `shared_buffers` no arquivo `postgresql.conf`.

- **Ferramentas Administrativas:**
  - Explore o **pgAdmin**:
    - Conecte-se a um banco de dados.
    - Crie tabelas e execute consultas.
  - Aprenda os comandos básicos do `psql`:

    ```sql
    \l  -- Lista bancos
    \dt -- Lista tabelas
    \?  -- Ajuda
    ```

---

#### 2. **Estrutura de Dados e SQL**

**Objetivos:**

- Entender como criar e manipular objetos no PostgreSQL.
- Escrever consultas SQL eficientes.

**Atividades e Recursos:**

- **Criação de Tabelas:**
  - Estruture um banco de dados simples (e.g., sistema de biblioteca):

    ```sql
    CREATE TABLE livros (
        id SERIAL PRIMARY KEY,
        titulo VARCHAR(100),
        autor VARCHAR(100),
        ano_publicacao INT
    );
    ```

  - Insira dados de teste:

    ```sql
    INSERT INTO livros (titulo, autor, ano_publicacao)
    VALUES ('Dom Casmurro', 'Machado de Assis', 1899);
    ```

- **Consultas SQL:**
  - Leia dados:

    ```sql
    SELECT * FROM livros;
    ```

  - Use filtros e ordenação:

    ```sql
    SELECT titulo, autor FROM livros WHERE ano_publicacao > 1900 ORDER BY titulo;
    ```

- **Índices:**
  - Crie índices simples e compostos:

    ```sql
    CREATE INDEX idx_ano ON livros(ano_publicacao);
    ```

- **Linguagem PL/pgSQL:**
  - Introdução à criação de funções:

    ```sql
    CREATE OR REPLACE FUNCTION soma(a INT, b INT) RETURNS INT AS $$
    BEGIN
        RETURN a + b;
    END;
    $$ LANGUAGE plpgsql;
    ```

  - Execute a função:

    ```sql
    SELECT soma(2, 3);
    ```

---

### **Próximos Passos**

Com essa base, você estará pronto para entrar na **Fase 2**. Sugiro praticar bastante esses conceitos em diferentes cenários.

**Sugestão de Ferramentas:**

- Simule problemas para praticar resolução.
- Use o site [SQLzoo](https://sqlzoo.net) para treinar consultas SQL.
- Teste com dados reais usando datasets públicos.

---
