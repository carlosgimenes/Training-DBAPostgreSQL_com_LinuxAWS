#CRIANDO UM USUÁRIO
CREATE USERR DBUSER1 WITH PASSWORD 'Aluno@Postgres';
#LISTANDO USUÁRIOS
\du
#OUTRA FORMA DE LISTAR USUÁRIOS
SELECT USENAME FROM PG_USER;

#UMA QUERY MAIS COMPLETA
SELECT usename AS role_name,
  CASE 
     WHEN usesuper AND usecreatedb THEN 
	   CAST('superuser, create database' AS pg_catalog.text)
     WHEN usesuper THEN 
	    CAST('superuser' AS pg_catalog.text)
     WHEN usecreatedb THEN 
	    CAST('create database' AS pg_catalog.text)
     ELSE 
	    CAST('' AS pg_catalog.text)
  END role_attributes
FROM pg_catalog.pg_user
ORDER BY role_name desc;