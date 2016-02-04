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
#export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar
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
#export PATH=$PATH:$HBASE_HOME/bin

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
    individual mode
    <property>
        <name>hbase.rootdir</name>
        <value>file:///home/tommy/hbase/</value>
    </property>

    cluster
    <property>
        <name>hbase.rootdir</name>
        <value>hdfs://localhost:9000/hbase</value>
    </property>
    <property>
        <name>hbase.cluster.distributed</name>
        <value>true</value>
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

```
进入hbase shell console

$HBASE_HOME/bin/hbase shell
如果有kerberos认证，需要事先使用相应的keytab进行一下认证（使用kinit命令），认证成功之后再使用hbase shell进入可以使用whoami命令可查看当前用户

hbase(main)> whoami
表的管理

1）查看有哪些表

hbase(main)> list
2）创建表

# 语法：create <table>, {NAME => <family>, VERSIONS => <VERSIONS>}
# 例如：创建表t1，有两个family name：f1，f2，且版本数均为2
hbase(main)> create 't1',{NAME => 'f1', VERSIONS => 2},{NAME => 'f2', VERSIONS => 2}
3）删除表

分两步：首先disable，然后drop

例如：删除表t1

hbase(main)> disable 't1'
hbase(main)> drop 't1'
4）查看表的结构

# 语法：describe <table>
# 例如：查看表t1的结构
hbase(main)> describe 't1'
5）修改表结构

修改表结构必须先disable

# 语法：alter 't1', {NAME => 'f1'}, {NAME => 'f2', METHOD => 'delete'}
# 例如：修改表test1的cf的TTL为180天
hbase(main)> disable 'test1'
hbase(main)> alter 'test1',{NAME=>'body',TTL=>'15552000'},{NAME=>'meta', TTL=>'15552000'}
hbase(main)> enable 'test1'
权限管理

1）分配权限

# 语法 : grant <user> <permissions> <table> <column family> <column qualifier> 参数后面用逗号分隔
# 权限用五个字母表示： "RWXCA".
# READ('R'), WRITE('W'), EXEC('X'), CREATE('C'), ADMIN('A')
# 例如，给用户‘test'分配对表t1有读写的权限，
hbase(main)> grant 'test','RW','t1'
2）查看权限

# 语法：user_permission <table>
# 例如，查看表t1的权限列表
hbase(main)> user_permission 't1'
3）收回权限

# 与分配权限类似，语法：revoke <user> <table> <column family> <column qualifier>
# 例如，收回test用户在表t1上的权限
hbase(main)> revoke 'test','t1'
表数据的增删改查

1）添加数据

# 语法：put <table>,<rowkey>,<family:column>,<value>,<timestamp>
# 例如：给表t1的添加一行记录：rowkey是rowkey001，family name：f1，column name：col1，value：value01，timestamp：系统默认
hbase(main)> put 't1','rowkey001','f1:col1','value01'
用法比较单一。

2）查询数据

a）查询某行记录

# 语法：get <table>,<rowkey>,[<family:column>,....]
# 例如：查询表t1，rowkey001中的f1下的col1的值
hbase(main)> get 't1','rowkey001', 'f1:col1'
# 或者：
hbase(main)> get 't1','rowkey001', {COLUMN=>'f1:col1'}
# 查询表t1，rowke002中的f1下的所有列值
hbase(main)> get 't1','rowkey001'
b）扫描表

# 语法：scan <table>, {COLUMNS => [ <family:column>,.... ], LIMIT => num}
# 另外，还可以添加STARTROW、TIMERANGE和FITLER等高级功能
# 例如：扫描表t1的前5条数据
hbase(main)> scan 't1',{LIMIT=>5}
c）查询表中的数据行数

# 语法：count <table>, {INTERVAL => intervalNum, CACHE => cacheNum}
# INTERVAL设置多少行显示一次及对应的rowkey，默认1000；CACHE每次去取的缓存区大小，默认是10，调整该参数可提高查询速度
# 例如，查询表t1中的行数，每100条显示一次，缓存区为500
hbase(main)> count 't1', {INTERVAL => 100, CACHE => 500}
3）删除数据

a )删除行中的某个列值

# 语法：delete <table>, <rowkey>,  <family:column> , <timestamp>,必须指定列名
# 例如：删除表t1，rowkey001中的f1:col1的数据
hbase(main)> delete 't1','rowkey001','f1:col1'
注：将删除改行f1:col1列所有版本的数据

b )删除行

# 语法：deleteall <table>, <rowkey>,  <family:column> , <timestamp>，可以不指定列名，删除整行数据
# 例如：删除表t1，rowk001的数据
hbase(main)> deleteall 't1','rowkey001'
c）删除表中的所有数据

# 语法： truncate <table>
# 其具体过程是：disable table -> drop table -> create table
# 例如：删除表t1的所有数据
hbase(main)> truncate 't1'
Region管理

1）移动region

# 语法：move 'encodeRegionName', 'ServerName'
# encodeRegionName指的regioName后面的编码，ServerName指的是master-status的Region Servers列表
# 示例
hbase(main)>move '4343995a58be8e5bbc739af1e91cd72d', 'db-41.xxx.xxx.org,60020,1390274516739'
2）开启/关闭region

# 语法：balance_switch true|false
hbase(main)> balance_switch
3）手动split

# 语法：split 'regionName', 'splitKey'
4）手动触发major compaction

#语法：

#Compact all regions in a table:
#hbase> major_compact 't1'
#Compact an entire region:
#hbase> major_compact 'r1'
#Compact a single column family within a region:
#hbase> major_compact 'r1', 'c1'
#Compact a single column family within a table:
#hbase> major_compact 't1', 'c1'
配置管理及节点重启

1）修改hdfs配置

hdfs配置位置：/etc/hadoop/conf

# 同步hdfs配置
cat /home/hadoop/slaves|xargs -i -t scp /etc/hadoop/conf/hdfs-site.xml hadoop@{}:/etc/hadoop/conf/hdfs-site.xml
#关闭：
cat /home/hadoop/slaves|xargs -i -t ssh hadoop@{} "sudo /home/hadoop/cdh4/hadoop-2.0.0-cdh4.2.1/sbin/hadoop-daemon.sh --config /etc/hadoop/conf stop datanode"
#启动：
cat /home/hadoop/slaves|xargs -i -t ssh hadoop@{} "sudo /home/hadoop/cdh4/hadoop-2.0.0-cdh4.2.1/sbin/hadoop-daemon.sh --config /etc/hadoop/conf start datanode"
2）修改hbase配置

hbase配置位置：

# 同步hbase配置
cat /home/hadoop/hbase/conf/regionservers|xargs -i -t scp /home/hadoop/hbase/conf/hbase-site.xml hadoop@{}:/home/hadoop/hbase/conf/hbase-site.xml
# graceful重启
cd ~/hbase
bin/graceful_stop.sh --restart --reload --debug inspurXXX.xxx.xxx.org
```

