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
###debian###
adduser --system --shell /bin/bash --home /home/hadoop hadoop
###centos###
adduser --system --shell /bin/bash --create-home --home-dir /home/hadoop hadoop

passwd hadoop  123456

3.
need three server, one master, two cluster
vi three server hosts file && add 
192.168.85.123 hadoop_node1
192.168.85.116 hadoop_node2
192.168.85.40 hadoop_node3

4.
ssh-keygen -t rsa in hadoop_node1 use hadoop user
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh

do it in two node server under hadoop user

ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hadoop_node1
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hadoop_node2
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hadoop_node3

login each server and ssh hadoop_node1,hadoop_node2,hadoop_node3

5.
go to three server and add sudo user for hadoop
sudo vim /etc/sudoers


6.
cd hadoop_node1 home
vim /etc/profile

export HADOOP_HOME=/home/hadoop/hadoop-2.7.1
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

source /etc/profile

7.
vim /home/hadoop/hadoop-2.7.1/etc/hadoop/hadoop-env.sh    
add
export JAVA_HOME=/usr/java/java7

mkdir /home/hadoop/hadoop-2.7.1/tmp
vim /home/hadoop/hadoop-2.7.1/etc/hadoop/core-site.xml  
add the below content into configuration

    <property>
        <name>fs.default.name</name>
        <value>hdfs://localhost:9000</value> 
    </property>
    <property>
        <name>dfs.replication</name> 
        <value>1</value> 
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/home/hadoop/hadoop-2.7.1/tmp</value> 
    </property>

cp /home/hadoop/hadoop-2.7.1/etc/hadoop/mapred-site.xml.template /home/hadoop/hadoop-2.7.1/etc/hadoop/mapred-site.xml
add the below content into configuration
    <property>
        <name>mapred.job.tracker</name>  
        <value>localhost:9001</value>   
    </property>




#export YARN_LOG_DIR=$HADOOP_LOG_DIR
```

###Verify Install
------
```
#hadoop version
```
