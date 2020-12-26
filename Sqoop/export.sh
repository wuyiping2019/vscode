#-------------------------------这是一条分隔线：导出脚本-------------------------------

#-------------------------------这是一条分隔线：hdfs全量导出到mysql-------------------------------
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
#               3）调用模式，sqoop为每条记录创建存储过程调用.

#-------------------------------这是一条分隔线：hdfs的updateonly模式导出到mysql------------------
sqoop export \
--connect jdbc:mysql://node-1:3306/userdb \
--username root \
--password hadoop \
--table emp \
--export-dir /updateonly_2/ \
--update-key id \
--update-mode updateonly

#-------------------------------这是一条分隔线：hdfs的allowinsert模式导出到mysql------------------
sqoop export \
--connect jdbc:mysql://node-1:3306/userdb \
--username root \
--password hadoop \
--table emp \
--export-dir /allowinsert_2/ \
--update-key id \
--update-mode allowinsert