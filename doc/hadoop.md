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
192.168.85.109 halo-cnode1
192.168.85.115 halo-cnode2
192.168.85.119 halo-cnode3

4.
ssh-keygen -t rsa in halo-cnode1 use hadoop user
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh

do it in two node server under hadoop user

ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@halo-cnode1
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@halo-cnode2
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@halo-cnode3

login each server and ssh halo-cnode1,halo-cnode2,halo-cnode3

5.
go to three server and add sudo user for hadoop
sudo vim /etc/sudoers


6.
cd halo-cnode1 home
vim /etc/profile

export HADOOP_HOME=/home/hadoop/hadoop-2.7.1
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

source /etc/profile

7.
vim /home/hadoop/hadoop-2.7.1/etc/hadoop/hadoop-env.sh    
add
export JAVA_HOME=/usr/java/java7

8.
mkdir /home/hadoop/hadoop-2.7.1/tmp
mkdir /home/hadoop/hadoop-2.7.1/hdfs/data
mkdir /home/hadoop/hadoop-2.7.1/hdfs/data
mkdir /home/hadoop/hadoop-2.7.1/hdfs/name

9.
vim /home/hadoop/hadoop-2.7.1/etc/hadoop/core-site.xml  
add the below content into configuration

    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://halo-cnode1:9000</value> 
    </property>
    <property>
        <name>dfs.replication</name> 
        <value>1</value> 
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/home/hadoop/hadoop-2.7.1/tmp</value> 
    </property>
    <property>
        <name>io.file.buffer.size</name>
        <value>131072</value>
    </property>

10.
cp /home/hadoop/hadoop-2.7.1/etc/hadoop/mapred-site.xml.template /home/hadoop/hadoop-2.7.1/etc/hadoop/mapred-site.xml
add the below content into configuration
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
        <final>true</final>
    </property>
    <property>
        <name>mapred.job.tracker</name>
        <value>halo-cnode1:9001</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.address</name>
        <value>halo-cnode1:10020</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.webapp.address</name>
        <value>halo-cnode1:19888</value>
    </property>
    <property>
        <name>mapreduce.jobtracker.http.address</name>
        <value>halo-cnode1:50030</value>
    </property>

11.
vim /home/hadoop/hadoop-2.7.1/etc/hadoop/hdfs-site.xml
add the below content into configuration
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:/home/hadoop/hadoop-2.7.1/hdfs/name</value>
    </property>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:/home/hadoop/hadoop-2.7.1/hdfs/data</value>
    </property>
    <property>
        <name>dfs.replication</name>
        <value>2</value>
    </property>
    <property>
        <name>dfs.namenode.secondary.http-address</name>
        <value>192.168.85.109:9001</value>
    </property>
    <property>
        <name>dfs.webhdfs.enabled</name>
        <value>true</value>
    </property>

12.
vim /home/hadoop/hadoop-2.7.1/etc/hadoop/yarn-site.xml
add the below content into configuration
    <property>
        <name>yarn.resourcemanager.hostname</name>
        <value>halo-cnode1</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.auxservices.mapreduce.shuffle.class</name>
        <value>org.apache.hadoop.mapred.ShuffleHandler</value>
    </property>
    <property>
        <name>yarn.resourcemanager.address</name>
        <value>halo-cnode1:8032</value>
    </property>
    <property>
        <name>yarn.resourcemanager.scheduler.address</name>
        <value>halo-cnode1:8030</value>
    </property>
    <property>
        <name>yarn.resourcemanager.resource-tracker.address</name>
        <value>halo-cnode1:8031</value>
    </property>
    <property>
        <name>yarn.resourcemanager.admin.address</name>
        <value>halo-cnode1:8033</value>
    </property>
    <property>
        <name>yarn.resourcemanager.webapp.address</name>
        <value>halo-cnode1:8088</value>
    </property>
    <property>
        <name>yarn.nodemanager.resource.memory-mb</name>
        <value>2048</value>
    </property>
    <property>
        <name>yarn.nodemanager.resource.cpu-vcores</name>
        <value>1</value>
    </property>

13.
vim slaves
delete localhost
add
halo
halo-cnode2
halo-cnode3

14.
copy halo-cnode1,halo
modify ulimit -n
vim /etc/security/limits.conf, for centos7
add the below content at the end of file then restart server
```
* soft nofile 102400
* hard nofile 102400
```
cat /proc/sys/fs/file-max  will affect the limits

15.
ntpdate
ntpdate time.windows.com

16.
close iptables,selinux
systemctl stop iptables
systemctl disable firewalld
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux; setenforce 0

17.
start
su - hadoop on halo-cnode1
start-all.sh
stop-all.sh


#export YARN_LOG_DIR=$HADOOP_LOG_DIR
```

###Verify Install
------
```
#hadoop version
```
