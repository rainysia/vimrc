HBase
=========
http://www.apache.org/dyn/closer.cgi/hbase/
    http://mirrors.cnnic.cn/apache/hbase

###Install

Install JAVA
------
http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html 

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

Install HBase
------
#cd /tmp && wget http://mirrors.cnnic.cn/apache/hbase/stable/hbase-1.1.2-bin.tar.gz
#tar -zxvf hbase-0.98.16.1-src.tar.gz -C /usr/
#cd /usr && mv hbase-0.98.16.1 hbase

#export HBASE_HOME=/usr/hbase
#export PATH="$PATH:$HBASE_HOME/bin"

gvim /usr/hbase/conf/hbase-env.sh 
uncomment and edit
export JAVA_HOME=/usr/java/java7/

#$HBASE_HOME/bin/start-hbase.sh
do it both in user mode


Usage
------
Edit conf/hbase-site.xml
