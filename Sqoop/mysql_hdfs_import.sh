#将Mysql中的数据全量导入HDFS
sqoop import \ #指定使用sqoop的import命令
--connect jdbs:mysql://node01:3306/userdb \ #指定JDBS连接字符串（指定数据库）
--username root \ #指定MySQL用户名
--password root \ #指定MySQL密码
--delete-target-dir \ #指定删除HDFS上上传数据的目录
--target-dir /sqoop/userdb \ #指定将数据上传到的HDFS目录
--table emp \ #指定需要导入的表
--m 1 #指定mapper的个数

sqoop import \ 
--connect jdbs:mysql://node01:3306/userdb \ 
--username root \ 
--password root \ 
--delete-target-dir \ 
--target-dir /sqoop/userdb \ 
--table emp \ 
--m 1 

