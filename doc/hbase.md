HBase
=========
Hbase Apache Download [Hbase Apache](http://www.apache.org/dyn/closer.cgi/hbase/)
China Hbase Fastest Node [China Hbase Node](http://mirrors.cnnic.cn/apache/hbase)

#Install

###Install JAVA
------
Oracle Java Download [Java 7](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html)
```
#mkdir /usr/java && cd /usr/java
#tar -zxvf jdk-7u79-linux-x64.tar.gz && mv jdk1.7.0_79 /usr/java/java7
#update-alternatives --install /usr/bin/java java /usr/java/java7/bin/java 1100
#update-alternatives --install /usr/bin/javac javac /usr/java/java7/bin/javac 1100
#update-alternatives --install /usr/bin/jar jar /usr/java/java7/bin/jar 1100
#update-alternatives --config java 
#update-alternatives --config javac
#update-alternatives --config jar

#export JAVA_HOME=/usr/java/java7
#export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
#export PATH=$PATH:$JAVA_HOME/bin
do it both in user mode
java -version
```

###Install HBase
------
```
#cd /tmp && wget http://mirrors.cnnic.cn/apache/hbase/stable/hbase-1.1.2-bin.tar.gz
#tar -zxvf hbase-0.98.16.1-src.tar.gz -C /usr/
#cd /usr && mv hbase-0.98.16.1 hbase

#export HBASE_HOME=/usr/hbase
#export PATH="$PATH:$HBASE_HOME/bin"

gvim /usr/hbase/conf/hbase-env.sh 
uncomment and edit
export JAVA_HOME=/usr/java/java7/
```

###Verify Install
------
```
#hbase version
```

Usage
------
###start hbase 
```
#$HBASE_HOME/bin/start-hbase.sh
or 
start-hbase.sh
```

###stop hbase
```
stop-hbase.sh
```

###modify default hbase tmp folder
    Edit conf/hbase-site.xml
    add the below content into <configuration>
```
    <property>
        <name>hbase.rootdir</name>
        <value>file:///home/tommy/hbase/</value>
    </property>
```

###go to hbase shell 
```
#hbase shell 
```
###open 60010 hbase web 
    Edit conf/hbase-site.xml
    add the below content into <configuration>
    http://127.0.0.1:60010
```
    <property>
        <name>hbase.master.info.port</name>
        <value>60010</value>
    </property>
```
###Address
```
http://{host}:50070/dfshealth.jsp     HBase build /hbase folder on HDFS for store data
http://{host}:60010/mster-status      HBase master page
http://{host}:60010/zk.jsp            ZooKeeper page
http://{host}:60010/table.jsp?name=wordcount Check wordcount table
http://{host}:60030/rs-status         Region server page
```

###Create Table need assign zookeeper data
    Edit conf/hbase-site.xml
    add the blow content into <configuration>
```
    <property>
        <name>hbase.zookeeper.property.dataDir</name>
        <value>/home/tommy/hbase/zookeeper</value>
    </property>
```

### Command
1.Create Table 
```
e.g.:create 'table_name','row family'
create 'mytable','cf'

e.g.:list    #list table
list
TABLE
mytable
t2
2 row(s) in 0.0060 seconds
```

2.Write Data
```
e.g.: put 'table_name','rowkey', 'row family:field_name', 'field_value'
put 'mytable','first','cf:message','hello HBase'
put 'mytable','second','cf:foo', 0x0
put 'mytable','third','cf:bar', 3.14159
```
3.Read Data by get/scan
```
e.g.: get 'table_name', 'rowkey'     #et table_name rowkey data
hbase(main):021:0> get 'mytable', 'first'
COLUMN                                                       CELL
 cf:message                                                  timestamp=1451036405579, value=hello HBase

e.g.: scan 'table_name'     #get all table_name data
hbase(main):022:0> scan 'mytable'
ROW                                                          COLUMN+CELL
 first                                                       column=cf:message, timestamp=1451036405579, value=hello HBase
 second                                                      column=cf:foo, timestamp=1451036428844, value=0
 third                                                       column=cf:bar, timestamp=1451036464702, value=3.14159
3 row(s) in 0.0210 seconds
```
