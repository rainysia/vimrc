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
hbase(main):017:0> status
1 servers, 0 dead, 5.0000 average load
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
create 'mytable','row_1'

e.g.:list    #list table
list
TABLE
mytable
t2
2 row(s) in 0.0060 seconds

hbase(main):018:0> list 'user'
TABLE
user
1 row(s) in 0.0060 seconds
=> ["user"]
```

2.Write Data
```
e.g.: put 'table_name','rowkey', 'row family:field_name', 'field_value'
put 'mytable','first','cf:message','hello HBase'
put 'mytable','second','cf:foo', 0x0
put 'mytable','third','cf:bar', 3.14159

e.g.: create 'user','info'
put 'user', 'row_1', 'info:name', 'tommy'
put 'user', 'row_2', 'info:name', 'susan'
put 'user', 'row_2', 'info:email', 'susanl@gmail.com'
```
3.Read Data by get/scan
```
e.g.: get 'table_name', 'rowkey'     #et table_name rowkey data
hbase(main):021:0> get 'mytable', 'first'
COLUMN                                                       CELL
 cf:message                                                  timestamp=1451036405579, value=hello HBase

e.g.: get 'user','row_2','info:email'

e.g.: scan 'table_name'     #get all table_name data
hbase(main):022:0> scan 'mytable'
ROW                                                          COLUMN+CELL
 first                                                       column=cf:message, timestamp=1451036405579, value=hello HBase
 second                                                      column=cf:foo, timestamp=1451036428844, value=0
 third                                                       column=cf:bar, timestamp=1451036464702, value=3.14159
3 row(s) in 0.0210 seconds
```

4. Describe table
```
e.g.: describe 'table_name'
hbase(main):011:0> describe 'user'
Table user is ENABLED
user
COLUMN FAMILIES DESCRIPTION
{NAME => 'info', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION_SCOPE => '0', VERSIONS => '1', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL => 'FOREVER', KEEP_DELETED_CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY
 => 'false', BLOCKCACHE => 'true'}
1 row(s) in 0.0170 seconds
```

5. Disable and Drop table
```
e.g.: disable 'table_name'
e.g.: drop 'table_name'
```

6. Delete one cell
```
e.g.: delete 'table_name', 'rowkey', 'col:qual'
>delete 'testtable','myrow-2','colfam1:q2'
```

7. All command
```
normal command

status
Version

DDL

alter
create
describe
disable
drop
enable
exists
is_disabled
is_enabled
List

DML

count
delete
delteall
get
get_counter
incr
put
scan
truncate

Tool

assign
balance_switch
balancer
compact
Flush
major_compact
Move
split
unassign
zk_dump

Replication

add_peer
disable_peer
enable_peer
remove_peer
start_replication
stop_replication
```
### Instruction
1.Hbase 
```
Hbase use coordinate.
[rowkey, column family,column qualifer(qual)]
[TheRealMT, info,       name]

Put p = new Put(Bytes.toBytes("TheRealMT"));
p.add(Bytes.toBytes("info")),
    Bytes.toBytes("name"),
    Bytes.toBytes("Mark Twain");
p.add(Bytes.toBytes("info")),
    Bytes.toBytes("email"),
    Bytes.toBytes("samuel@clemens.org");
p.add(Bytes.toBytes("info")),
    Bytes.toBytes("password"),
    Bytes.toBytes("Langhorne");

hbase(main):019:0> put 'user','TheRealMT','info:name','Chouting'
0 row(s) in 0.0420 seconds
hbase(main):020:0> put 'user','TheRealMT','info:name','Tommy'
0 row(s) in 0.0040 seconds
```

