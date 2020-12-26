
#-------------------------------这是一条分隔线：查看mysql数据库-------------------------------
#查看指定mysql的数据库
sqoop list-databases \
 --connect jdbc:mysql://localhost:3306/ \
 --username root \
 --password root \
#-------------------------------这是一条分隔线：将数据全量导入hdfs--------------------------
#导入mysql表数据到HDFS
#如果--m 1时，可以不指定--split-by
sqoop import \
--connect jdbc:mysql://node-1:3306/userdb \
--username root \
--password hadoop \
--table emp \
--target-dir /sqoopresult214 \
--fields-terminated-by '\t' \
--split-by id \
--m 2
#-------------------------------这是一条分隔线：将数据全量导入hive------------------------------
#导入mysql表数据到HIVE
#1 先复制表结构再导入数据
#1.1 将关系型数据的表结构复制到hive中
sqoop create-hive-table \
--connect jdbc:mysql://node-1:3306/userdb \
--table emp_add \
--username root \
--password hadoop \
--hive-table test.emp_add_sp 
#1.2 从关系数据库导入文件到hive中
sqoop import \
--connect jdbc:mysql://node-1:3306/userdb \
--username root \
--password hadoop \
--table emp_add \
--hive-import \
--hive-table test.emp_add_sp \
--split-by id \
--m 2
#2 直接导入数据到hive中，包括表结构和数据
sqoop import \
--connect jdbc:mysql://node-1:3306/userdb \
--username root \
--password hadoop \
--table emp_conn \
--hive-import \
--hive-database test;
--split-by id \
--m 2
#-------------------------------这是一条分隔线：使用where参数过滤导入HDFS-------------------------
sqoop import \
--connect jdbc:mysql://node-1:3306/userdb \
--username root \
--password hadoop \
--where "city ='sec-bad'" \
--target-dir /wherequery \
--table emp_add \
--split-by id \
--m 2
#-------------------------------这是一条分隔线：使用quey参数过滤导入HDFS-------------------------
sqoop import \
--connect jdbc:mysql://node-1:3306/userdb \
--username root \
--password hadoop \
--target-dir /wherequery12 \
--query 'select id,name,deg from emp WHERE  id>1203 and $CONDITIONS' \
--split-by id \
--fields-terminated-by '\001' \
--m 2
#备注
#使用sql语句来进行查找是不能加参数--table 
#必须要添加where条件，
#where条件后面必须带一个$CONDITIONS 这个字符串，
#这个sql语句必须用单引号，不能用双引号
#-------------------------------这是一条分隔线：Append模式增量导入HDFS-------------------------
sqoop import \
--connect jdbc:mysql://node-1:3306/userdb \
--username root \
--password hadoop \
--table emp \
--target-dir /appendresult \
--incremental append \
--check-column id \
--last-value 1205 \
--split-by id \
--m 2
#备注
#append模式会将大于check-column列指定last-value值的数据导入
#-------------------------------这是一条分隔线：Lastmodify模式下append模式增量导入HDFS----------
bin/sqoop import \
--connect jdbc:mysql://node-1:3306/userdb \
--username root \
--password hadoop \
--table customertest \
--target-dir /lastmodifiedresult \
--check-column last_mod \
--incremental lastmodified \
--append \
--last-value "2019-05-28 18:42:06" \
--m 1
#备注
#lastmodify模式下的append模式会将大于或等于check-column的last-value的数据导入
#-------------------------------这是一条分隔线：Lastmodify模式下merge-key模式增量导入HDFS--------
sqoop import \
--connect jdbc:mysql://node-1:3306/userdb \
--username root \
--password hadoop \
--table customertest \
--target-dir /lastmodifiedresult \
--check-column last_mod \
--incremental lastmodified \
--merge-key id \
--last-value "2019-06-05 15:52:58" \
--m 1 \
#备注
#lastmodify模式的merge-key会检查大于或等于check-column列的last-value值的数据
#将大于或等于指定列的数据进行导入，如果某条数据的merge-id存在则执行更新操作，
#如果某条数据的merge-id不存在则执行插入操作
#hive的更新操作并不会修改存储再在hdfs上的数据，而是以追加的方式写入新的文件
#-------------------------------这是一条分隔线：HDFS全量导出到mysql-------------------------------
sqoop export \
--connect jdbc:mysql://node-1:3306/userdb \
--username root \
--password hadoop \
--table employee1 \
--columns id,name,deg,salary,dept \
--export-dir /emp_data/ 
#备注
#mysql导出的目标表必须存在
#export三种模式：1）默认模式，使用insert语句；
#               2）更新模式，使用update语句；
#               3）调用模式，sqoop为每条记录创建存储过程调用；
#-------------------------------这是一条分隔线：HDFS的updateonly模式导出到mysql------------------
sqoop export \
--connect jdbc:mysql://node-1:3306/userdb \
--username root \
--password hadoop \
--table emp \
--export-dir /updateonly_2/ \
--update-key id \
--update-mode updateonly
#-------------------------------这是一条分隔线：HDFS的allowinsert模式导出到mysql------------------
sqoop export \
--connect jdbc:mysql://node-1:3306/userdb \
--username root \
--password hadoop \
--table emp \
--export-dir /allowinsert_2/ \
--update-key id \
--update-mode allowinsert