mysqld --initialize

mysqld --console --explicit_defaults_for_timestamp --skip-grant-tables &

mysql -u root mysql

update USER set authentication_string=password('[설정할 암호]') where user='root';

flush privileges;

alter user 'root'@'localhost' identified by '[설정할 암호]';

이후 인코딩을 위해 my.ini 업데이트

