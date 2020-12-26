# Sqoop介绍

- Apache Sqoop 是在 Hadoop 生态体系和 RDBMS 体系之间传送数据的一种工具。来自于 Apache 软件基金会提供。
- Sqoop 工作机制是将导入或导出命令翻译成 mapreduce 程序来实现。在翻译出的 mapreduce 中主要是对inputformat 和 outputformat 进行定制。
- Hadoop 生态系统包括：HDFS、Hive、Hbase等
- RDBMS 体系包括：Mysql、Oracle、DB2等
- Sqoop 可以理解为： “SQL到Hadoop和Hadoop到SQL” 