# 1.Data flow model

- Flume是一个分布式的、可靠的、高效的系统，可用于收集不同来源的日志数据并将其存储到一个中央存储系统。

- Flume中执行工作的进程是Agent，该进程是一个JVM进程，包含三个组件：Source、Channel和Sink。

- Source组件对接数据源，执行采集数据的工作；Channel组件负责数据的临时存储，Source组件采集到的数据将会存储在Channel中，Channel存储数据的方式可以是内存、文件等；Sink组件负责将Channel中存储的数据发送到指定的目的地进行最终存储。

- 数据在Agent中是以Event进行封装的，每一条数据就是一个Event包含一个header和