<img src="https://storage.googleapis.com/golden-wind/experts-club/capa-github.svg" />

# Segurança de serviços rest em um backend feito em shelf com Jaguar_jwt

Nesse vídeo criaremos um   middleware de segurança para validação e verificação de de permissões m em acesso a serviços rest utilizando jaguar_jwt em backend Dart com shelf

# Passo a passo
Rode o script abaixo no seu banco de dados e altere o arquivo database_connection.dart dentro da pasta /lib/application/database/ colocando seus dados de conexão

## Script de banco
```sql
create table usuario(
	cd_usuario int auto_increment primary key not null,
    ds_email varchar(200) not null,
    ds_senha text not null
);

insert into usuario values(null, 'rodrigorahman@academiadoflutter.com.br', '96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e');
```


## Expert
| [<img src="https://avatars.githubusercontent.com/u/20157178?s=400&u=e3e485b5e3bb7b6194b351b0e4b34303740bae1e&v=4" width="75px;"/>](https://github.com/rodrigorahman) |
| :-: |
|[Rodrigo Rahman](https://github.com/rodrigorahman)|