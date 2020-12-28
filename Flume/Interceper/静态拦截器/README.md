# 1 场景介绍

A、B两台日志服务机器实时生产日志主要类型为access.log、nginx.log、web.log
现在要求：
把A、B 机器中的access.log、nginx.log、web.log 采集汇总到C机器上然后统一收集到hdfs中。  
但是在hdfs中要求的目录为：  
/source/logs/access/日期/**  
/source/logs/nginx/日期/**  
/source/logs/web/日期/**
![avatar](/images/pic5.png)

# 2 服务的启动

在C服务上执行：

```shell
flume-ng agent \
-c conf \
-f conf/avro_hdfs.conf \
-name a1 \
-Dflume.root.logger=DEBUG,console
```

在A和B上分别执行：

```shell
flume-ng agent \
-c conf \
-f conf/exec_avro.conf \
-name a1 \
-Dflume.root.logger=DEBUG,console  
```
