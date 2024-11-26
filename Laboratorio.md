# DBA PostgreSQL com Linux AWS CentOS, Red Hat, Debian

## Montagem Laboratório de Estudo

### Host Linux Ubuntu Server 24.04.1 LTS

A partir do meu Grupo de Templates do VirtualBox, clonar **LAB-xxx-SRV01**.

- Nome: **LAB-DB-SRV01**
- Política de Endereço MAC: **Gerar novos endereços MAC para todas as placas de rede**
- Registrar na Planilha de Controle: **IP utilizado e Definição de Memória**
- Ajustar Descrição da VM: **Nome de Host e IP**
- Ajustar Memória da VM: **Conforme registrado na Planilha de Controle**

Pós Clonagem.

- Criar entrada no Remmina
- Identificar Placa de Rede:

  ```bash
  id add
  ```

- Ajustar arquivo `ConfigurarRedeComIpFixo.sh`
  - Placa de Rede: **enp0s3**
  - IP_ADDRESS: **192.168.0.201/24**
- Executar o arquivo para efetivar as alterações:

    ```bash
    sudo ./ConfigurarRedeComIpFixo.sh
    ```

- Ajustar Hostname
  1. **Altere o nome da máquina temporariamente** até a próxima reinicialização:

     ```bash
     sudo hostnamectl set-hostname novonome
     ```
  
  2. **Edite o arquivo `/etc/hostname`** para fazer a mudança permanente:

     ```bash
     sudo nano /etc/hostname
     ```

     Substitua o nome atual pelo novo nome e salve o arquivo.
  
  3. **Edite o arquivo `/etc/hosts`** para refletir a mudança. Abra o arquivo:

     ```bash
     sudo nano /etc/hosts
     ```

     Substitua todas as ocorrências do nome antigo pelo novo nome. O arquivo `/etc/hosts` geralmente tem uma linha semelhante a esta:

     ```bash
     127.0.1.1       nomeantigo
     ```

     Altere para:

     ```bash
     127.0.1.1       novonome
     ```

     Salve o arquivo e saia do editor
  
  4. **Reinicie a máquina** para aplicar as mudanças:

     ```bash
     sudo reboot
     ```
  
  Substitua `novonome` pelo nome desejado para a máquina. Após a reinicialização, o novo nome da máquina será efetivo.

- Efetue a atualização dos pacotes

  ```bash
  sudo apt update
  sudo apt upgrade
  ```

---

### Instalação PostgreSQL 16

[Link para página de Download PostgreSQL para Ubuntu](https://www.postgresql.org/download/linux/ubuntu/)

**Opção 1: Included in Distribution**

Ubuntu includes PostgreSQL by default. To install PostgreSQL on Ubuntu, use the apt (or other apt-driving) command:

```bash
apt install postgresql
```

**Opção 2: PostgreSQL Apt Repository**

If the version included in your version of Ubuntu is not the one you want, you can use the PostgreSQL Apt Repository. This repository will integrate with your normal systems and patch management, and provide automatic updates for all supported versions of PostgreSQL throughout the support lifetime of PostgreSQL.

- Automated repository configuration:

```bash
sudo apt install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
```

- To manually configure the Apt repository, follow these steps:

```bash
sudo apt install curl ca-certificates
sudo install -d /usr/share/postgresql-common/pgdg
sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
sudo sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
sudo apt update
sudo apt -y install postgresql-16 postgresql-client-16 postgresql-contrib
```

Explicando o que acontece ao executar o comando:

```bash
sudo apt -y install postgresql-16 postgresql-client-16 postgresql-contrib
```

### Análise do comando

1. **`sudo`**:
   - Significa *super user do* e é usado para executar o comando com privilégios administrativos. Isso é necessário porque a instalação de pacotes no sistema exige permissões elevadas.

2. **`apt`**:
   - É o gerenciador de pacotes padrão das distribuições baseadas em Debian, como o Ubuntu. Ele é usado para instalar, atualizar ou remover pacotes de software.

3. **`-y`**:
   - Esse parâmetro responde automaticamente "sim" para todas as perguntas que o instalador possa fazer durante o processo. Isso permite que a instalação ocorra sem interrupções.

4. **`install`**:
   - É o comando que diz ao `apt` para instalar os pacotes listados em seguida.

5. **Pacotes a serem instalados**:
   - **`postgresql-16`**:
     - Este pacote instala o servidor do PostgreSQL, especificamente a versão 12. O servidor é a parte principal que gerencia os bancos de dados.
   - **`postgresql-client-16`**:
     - Este pacote instala o cliente do PostgreSQL, que inclui ferramentas como `psql`. Com ele, você pode se conectar ao servidor PostgreSQL local ou remoto e executar comandos SQL.
   - **`postgresql-contrib`**:
     - Este pacote adiciona extensões adicionais e utilitários opcionais para o PostgreSQL, como o suporte a tabelas adicionais ou funcionalidades extras úteis no gerenciamento do banco de dados (exemplo: módulos como `pg_stat_statements`).

---

### O que esperar após a execução?

1. O Ubuntu irá:
   - Baixar os pacotes necessários do repositório oficial.
   - Configurar os arquivos principais do PostgreSQL.
   - Iniciar o serviço PostgreSQL.

2. O servidor PostgreSQL estará rodando e escutando na porta padrão (5432).

3. Um usuário padrão chamado `postgres` será criado, que tem permissões administrativas no banco de dados.

4. Você poderá se conectar ao PostgreSQL usando o comando:

   ```bash
   sudo -i -u postgres psql
   ```

### Passos adicionais recomendados

- **Alterar a senha do usuário `postgres`**:
  Após entrar no `psql`, execute:

  ```sql
  \password postgres
  ```

- **Verificar se o serviço está rodando**:

  ```bash
  sudo systemctl status postgresql
  ```

- **Verificar se o PostgreSQL está habilitado para restart automático**:
  Para isso use o comando:

  ```bash
  sudo systemctl is-enabled postgresql
  ```

  Você deve ter um retorno como `enabled`

- **Faça uma primeira conexão com o PostgreSQL**:
  Você precisa estar com o user `postgres` esse user é um superadmin:

  ```bash
  sudo su - postgres
  ```

  Em seguida conecte-se com o utilitário `psql`:

  ```bash
  psql
  ```

  Faça um teste utilizando a função conninfo para trazer o status:

  ```bash
  \conninfo
  ```

  Você deve ter um retorno como:
  
  ```text
  You are connected to database "postgres" as user "postgres" via socket in "/var/run/postgresql" at port "5432".
  ```

### Permitindo acesso através de uma conexão externa ao servidor do PostgreSQL

Para permitir acesso externo ao PostgreSQL, é necessário ajustar algumas configurações no servidor. Por padrão, o PostgreSQL permite conexões apenas a partir do próprio servidor (localhost). Para liberar acesso externo, vamos precisar modificar alguns arquivos e ajustar a configuração da rede.

Aqui está o passo a passo:

---

#### 1. **Editar o arquivo `postgresql.conf`**

Este arquivo controla as configurações gerais do PostgreSQL, incluindo a forma como ele escuta conexões.

- Abra o arquivo de configuração:

  ```bash
  sudo nano /etc/postgresql/16/main/postgresql.conf
  ```

  (Substitua `16` pela versão do PostgreSQL instalada, caso seja diferente).

- Procure pela linha que define o parâmetro `listen_addresses`:
  
  ```conf
  #listen_addresses = 'localhost'
  ```

- Altere-a para incluir o endereço IP do servidor ou para `'*'` (para escutar em todos os IPs disponíveis):

  ```conf
  listen_addresses = '*'
  ```

- Salve e saia do editor (`Ctrl+O`, `Enter`, `Ctrl+X` no Nano).

---

#### 2. **Editar o arquivo `pg_hba.conf`**

Este arquivo define as regras de autenticação de clientes.

- Abra o arquivo:
  
  ```bash
  sudo nano /etc/postgresql/12/main/pg_hba.conf
  ```

- Adicione uma linha para permitir conexões externas. Por exemplo:
  
  ```conf
  host    all             all             0.0.0.0/0            md5
  ```
  
  Aqui está o que cada campo significa:
  - **`host`**: Permite conexões via TCP/IP.
  - **`all`** (primeiro): Refere-se ao banco de dados ao qual o acesso é permitido. Use `all` para permitir acesso a todos os bancos.
  - **`all`** (segundo): Refere-se aos usuários permitidos. Use `all` para permitir a qualquer usuário autenticado.
  - **`0.0.0.0/0`**: Permite conexões de qualquer endereço IP. Você pode restringir isso a um intervalo de IPs, como `192.168.1.0/24`.
  - **`md5`**: Especifica o método de autenticação. Aqui estamos usando a autenticação com senha criptografada.

- Salve e saia do editor.

---

#### 3. **Reiniciar o PostgreSQL**

Após as alterações, reinicie o serviço PostgreSQL para aplicar as mudanças:

```bash
sudo systemctl restart postgresql
```

---

#### 4. **Configurar o firewall**

Se houver um firewall ativo no servidor, precisaremos liberar a porta padrão do PostgreSQL (5432) para conexões externas.

- No Ubuntu, usando `ufw`:
  
  ```bash
  sudo ufw allow 5432/tcp
  ```

- Verifique as regras do firewall para garantir que a porta esteja liberada:

  ```bash
  sudo ufw status
  ```

---

#### 5. **Testar a conexão**

Agora, de outro computador, podemos tentar se conectar ao PostgreSQL usando o cliente `psql` ou uma ferramenta como DBeaver, pgAdmin, ou outro. Certifique-se de usar o IP do servidor PostgreSQL e a porta correta.

Exemplo de conexão com `psql`:

```bash
psql -h <IP_do_servidor> -p 5432 -U <usuário> -d <nome_do_banco>
```

---

#### Dicas de segurança

1. **Restringir acesso por IP**:
   Em vez de permitir conexões de `0.0.0.0/0`, limite as conexões a IPs específicos ou faixas conhecidas.

2. **Usar métodos de autenticação seguros**:
   O método `md5` é seguro para senhas criptografadas, mas considere autenticação com certificados ou métodos mais seguros, dependendo do cenário.

3. **Monitorar logs de acesso**:
   Verifique os logs para monitorar conexões externas suspeitas

   ```bash
   sudo tail -f /var/log/postgresql/postgresql-16-main.log
   ```

Seguindo esses passos, teremos o PostgreSQL configurado para aceitar conexões externas de forma segura!

---

Pronto já temos o PostgreSQL rodando e pronto para realização do nosso Laboratório, bons estudos.

---
