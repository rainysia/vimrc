Hadoop
=======
Hadoop Download [Hadoop Apache](https://hadoop.apache.org/releases.html)
China Hadoop Fastest Node [China Hadoop Node](http://mirrors.cnnic.cn/apache/hadoop/common)
Hadoop Opencas Node [Hadoop Opencas Node](http://apache.opencas.org/hadoop/common/)
Hadoop Fayea Node[Hadoop Fayea Node](http://apache.fayea.com/hadoop/common/)

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

###Install Hadoop
------
```
1. 
#cd /tmp && wget http://apache.fayea.com/hadoop/common/current/hadoop-2.7.1.tar.gz
#tar -zxvf hadoop-2.7.1.tar.gz -C /usr/
#cd /usr && mv hadoop-2.7.1 hadoop

2.
#export HADOOP_HOME=/usr/hadoop
#export YARN_LOG_DIR=$HADOOP_LOG_DIR

#export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

3.
###debian###
adduser --system --shell /bin/bash --home /home/hadoop hadoop
###centos###
adduser --system --shell /bin/bash --create-home --home-dir /home/hadoop hadoop

passwd hadoop  123456

4.
need three server, one master, two cluster
vi three server hosts file && add 
192.168.85.123 hadoop_master
192.168.85.116 hadoop_node1
192.168.85.40 hadoop_node2

5.
ssh-keygen -t rsa in hadoop_master use hadoop user
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh

do it in two node server

ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hadoop_master
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hadoop_node1
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hadoop_node2

6.
```

###Verify Install
------
```
#hadoop version
```
