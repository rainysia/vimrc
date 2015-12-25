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
```
    <property>
        <name>hbase.master.info.port</name>
        <value>60010</value>
    </property>
```



