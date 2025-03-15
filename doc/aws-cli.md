# Adicionar credenciais no arquivo `~/.aws/credentials`

```bash
[default]
aws_access_key_id = fake_key
aws_secret_access_key = fake_secret

[backupUser]
aws_access_key_id = fake_key
aws_secret_access_key = fake_secret
```

### Upload

```bash
aws s3 cp ~/image.png s3://my-bucket/fotos/image.png # default profile
aws s3 cp ~/image.png s3://my-bucket/fotos/image.png --profile backupUser
```

### Download

```bash
aws s3 cp s3://my-bucket/fotos/image.png ~/image_downloaded.png # default profile
aws s3 cp s3://my-bucket/fotos/image.png ~/image_downloaded.png --profile backupUser
```
### Delete

```bash
aws s3 rm s3://my-bucket/fotos/image.png # default profile
aws s3 rm s3://my-bucket/fotos/image.png --profile backupUser
```

### Listar

```bash
aws s3 ls s3://my-bucket/ # default profile
aws s3 ls s3://my-bucket/ --profile backupUser
```
