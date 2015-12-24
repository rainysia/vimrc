Hbase
=========
http://www.apache.org/dyn/closer.cgi/hbase/
    http://mirrors.cnnic.cn/apache/hbase

Install
------

JAVA
http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html 

#mkdir /usr/java && cd /usr/java
#tar -zxvf jdk-7u79-linux-x64.tar.gz && mv jdk1.7.0_79 /usr/java/java7
#update-alternatives --install /usr/bin/java java /usr/java/java7/bin/java 1100
#update-alternatives --install /usr/bin/javac javac /usr/java/java7/bin/javac 1100
#update-alternatives --config java 
#update-alternatives --config javac

#export JAVA_HOME=/usr/java/java7
#export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
#export PATH=$PATH:$JAVA_HOME/bin
do it both in user mode
java -version

#mkdir /usr/hbase && cd /usr/hbase
#wget http://mirrors.cnnic.cn/apache/hbase/0.98.16.1/hbase-0.98.16.1-src.tar.gz
#tar -zxvf hbase-0.98.16.1-src.tar.gz

#export HBASE_HOME=/usr/hbase/hbase-0.98.16.1
#export PATH="$PATH:$HBASE_HOME/bin"
#$HBASE_HOME/bin/start-hbase.sh
do it both in user mode


