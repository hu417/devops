mkdir -p /data/mysql/{conf,data,log}
chmod -R 777 /data/mysql/*


vim /data/mysql/conf/my.cnf
[client]
default-character-set=utf8mb4
 
[mysql]
default-character-set=utf8mb4

[mysqld]
init-connect="SET collation_connection=utf8mb4_0900_ai_ci"
init-connect="SET NAMES utf8mb4"
character-set-server=utf8mb4
collation-server=utf8mb4_0900_ai_ci
skip-character-set-cli
skip-name-resolve
skip-character-set-client-handshake
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION



docker run \
--name mysql \
-d \
-p 3306:3306 \
--restart unless-stopped \
-v ./mysql/log:/var/log/mysql \
-v ./mysql/data:/var/lib/mysql \
-v ./mysql/conf/my.cnf:/etc/my.cnf \
-v /etc/localtime:/etc/localtime \
-e LANG="C.UTF-8" \
-e TZ=Asia/Shanghai \
-e MYSQL_ROOT_PASSWORD=123456 \
-d mysql:8.0.31 --lower_case_table_names=1


1、进入镜像中的mysql（ti 后面的字符串是mysql镜像ID）
docker exec -ti mysql /bin/bash
2、登录mysql
mysql -uroot -p123456
3、修改root 可以通过任何客户端连接
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
4、刷新命令生效
flush privileges;

创建用户并授权
create user 'sre'@'%' identified by '111111';
grant all on *.* to 'sre'@'%' with grant option;
flush privileges;

创建数据库
Create Database If Not Exists devops Character Set utf8mb4;
创建表
Create Table If Not Exists `test`(
`ID` Bigint(8) unsigned Primary key Auto_Increment,
`Name` text
)Engine InnoDB DEFAULT CHARSET=utf8mb4;
