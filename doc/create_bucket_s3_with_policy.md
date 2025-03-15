# Configuração de Bucket S3 com Políticas de Acesso para Usuário IAM

Este guia fornece as etapas necessárias para criar um bucket S3 na AWS, configurar políticas de acesso para um usuário IAM, e permitir as permissões de **upload**, **download** e **delete** para arquivos dentro do bucket.

## Passo 1: Criar o Bucket S3

1. **Acesse o Console da AWS**:
   - Navegue até o serviço **S3** na AWS.

2. **Criar um Novo Bucket**:
   - Clique em **Create bucket**.
   - Dê um nome único para o seu bucket (por exemplo, `meu-bucket-backup`).
   - Escolha a região desejada para o bucket.
   - Deixe as demais configurações como estão e clique em **Create**.

## Passo 2: Criar uma Política de Acesso para o Bucket S3

Agora, vamos criar uma política de IAM para conceder permissões específicas ao usuário, como fazer upload, download e deletar arquivos no bucket S3.

### 2.1 Criar a Política de Acesso

1. **Acesse o Console IAM**:
   - No Console da AWS, vá até o serviço **IAM**.

2. **Criar uma Nova Política**:
   - No menu lateral, clique em **Policies**.
   - Clique em **Create policy**.
   - Selecione a aba **JSON** e insira o seguinte código:

   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": [
           "s3:ListBucket",
           "s3:GetObject",
           "s3:PutObject",
           "s3:DeleteObject"
         ],
         "Resource": [
           "arn:aws:s3:::nome-do-seu-bucket",
           "arn:aws:s3:::nome-do-seu-bucket/*"
         ]
       }
     ]
   }

- Substitua `nome-do-seu-bucket` pelo nome real do seu bucket (ex: `meu-bucket-backup`).
- **`s3:ListBucket`**: Permite listar os objetos dentro do bucket.
- **`s3:GetObject`**: Permite baixar arquivos do bucket.
- **`s3:PutObject`**: Permite fazer upload de arquivos para o bucket.
- **`s3:DeleteObject`**: Permite deletar arquivos do bucket.

3. **Revisar e Criar a Política**:
   - Clique em **Review policy**.
   - Dê um nome à política (ex: `S3BackupFullAccessPolicy`).
   - Clique em **Create policy**.

### 2.2 Associar a Política ao Usuário IAM

1. **Acesse o Usuário IAM**:
   - No Console IAM, clique em **Users**.
   - Selecione o usuário que você deseja conceder acesso ao bucket S3 (ex: `BackupUser`).

2. **Adicionar a Política ao Usuário**:
   - No painel de permissões do usuário, clique em **Add permissions**.
   - Selecione **Attach policies directly**.
   - Procure pela política que você criou (`S3BackupFullAccessPolicy`).
   - Selecione a política e clique em **Next** e depois em **Add permissions**.

## Passo 3: Testar o Acesso com AWS CLI

Após configurar as permissões, você pode testar o acesso ao bucket S3 usando a AWS CLI.

### 3.1 Configurar as Credenciais do Usuário IAM na AWS CLI

Se ainda não tiver configurado as credenciais do usuário IAM na AWS CLI, execute o seguinte comando:

```bash
aws configure
```

Digite as credenciais do usuário IAM que você acabou de criar.

### 3.2 Testar o Upload de Arquivo

Para testar o upload de um arquivo para o bucket S3, use o seguinte comando:

```bash
aws s3 cp caminho/do/arquivo.txt s3://nome-do-seu-bucket/ --region sua-regiao
```

### 3.3 Testar o Download de Arquivo

Para testar o download de um arquivo do bucket S3, use o comando:

```bash
aws s3 cp s3://nome-do-seu-bucket/arquivo.txt caminho/do/destino/ --region sua-regiao
```

### 3.4 Testar o Delete de Arquivo

Para testar a exclusão de um arquivo no bucket S3, use o comando:

```bash
aws s3 rm s3://nome-do-seu-bucket/arquivo.txt --region sua-regiao
```

## Conclusão

Com as permissões configuradas, o usuário IAM agora pode:

- **Listar objetos** no bucket S3 (`s3:ListBucket`).
- **Fazer upload** de arquivos para o bucket (`s3:PutObject`).
- **Fazer download** de arquivos do bucket (`s3:GetObject`).
- **Deletar arquivos** do bucket (`s3:DeleteObject`).

Essas permissões podem ser úteis para gerenciar backups ou qualquer outro processo que envolva manipulação de arquivos dentro do S3.

---

### Dicas Adicionais

- **Revogar Permissões**: Se você quiser revogar qualquer permissão, basta remover a ação correspondente da política.
- **Política de Acesso Restrita**: Você pode criar políticas mais restritivas se precisar que o usuário tenha acesso apenas a um determinado diretório dentro do bucket, ou a arquivos específicos, utilizando a sintaxe do `arn:aws:s3:::nome-do-seu-bucket/pasta/*`.
- **Monitoramento**: Considere habilitar o AWS CloudTrail para monitorar as ações realizadas no seu bucket S3.

---