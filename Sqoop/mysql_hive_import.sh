#方式一：先复制表结构到Hive，然后将数据全量导入
#首先复制表结构
sqoop create-hive-table \ #指定使用create-hive-table命令
--connect jdbd:mysql://node01:3306/userdb \ #指定连接MySQL字符串
--username root \ #指定MySQL用户名
--password root \ #指定MySQL密码
--table emp \ #指定MySQL中的表
--hive-table test.emp_copy  #指定在Hive的test数据库中复制emp表并命名为emp_copy

#然后将数据导入HDFS
sqoop import \ #指定使用import命令
--connct jdbc:mysql://node01:3306/userdb \ #指定连接MySQL字符串
--username root \ #指定MySQL用户名
--password root \ #指定MySQL密码
--table emp \ #指定需要导入的表
--hive-import \ #指定将数据导入Hive中
--hive-table test.emp_copy \ #指定导入Hive的表
--m 1 #指定mapper的个数

#方式二：直接将数据Hive，包括复制表结构
sqoop import \ #指定使用import命令
--connect jdbc:mysql://node01:3306/userdb \ #指定mysql连接字符串
--username root \ #指定mysql用户名
--password root \ #指定mysql密码
--table emp \ #指定导入的mysql表
--hive-import \ #指定将数据导入hive
--hive-database test \ #指定将数据导入hive的test数据库
--m 1 #指定mapper的个数

#方式一：复制表结构可以对表进行重命名，然后将mysql数据导入到指定的hive表
#方式二：直接将表数据导入并且表名保持相同

#COPY COMMAND-----------------------------------------------------------------------------------

#复制表结构到Hive
sqoop create-hive-table \
--connect jdbd:mysql://node01:3306/userdb \ 
--username root \
--password root \
--table emp \
--hive-table test.emp_copy

#将mysql数据导入指定hive表
sqoop import \
--connect jdbc:mysql://node01:3306/userdb \
--username root \
--password root \
--table emp \
--hive-import \
--hive-database test \
--m 1

#将mysql数据导入hive
sqoop import \
--connect jdbc:mysql://node01:3306/userdb \
--username root \
--password root \
--table emp \
--hive-import \
--hive-database test \
--m 1