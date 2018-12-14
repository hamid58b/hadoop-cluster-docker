FROM ubuntu:14.04


MAINTAINER KiwenLau <kiwenlau@gmail.com>

WORKDIR /root

# install openssh-server, openjdk and wget
RUN apt-get update && apt-get install -y openssh-server openjdk-7-jdk wget bash

# install hadoop 1.2.1
# url address from apache website: https://archive.apache.org/dist/hadoop/core/hadoop-1.2.1/hadoop-1.2.1.tar.gz
RUN wget https://archive.apache.org/dist/hadoop/core/hadoop-1.2.1/hadoop-1.2.1.tar.gz  && \
    tar -xzvf hadoop-1.2.1.tar.gz && \
    mv hadoop-1.2.1 /usr/local/hadoop && \
    rm hadoop-1.2.1.tar.gz

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
ENV HADOOP_HOME=/usr/local/hadoop
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN mkdir -p ~/hdfs/namenode && \
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh $HADOOP_HOME/conf/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/conf/hdfs-site.xml && \
    mv /tmp/core-site.xml $HADOOP_HOME/conf/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/conf/mapred-site.xml && \
    # mv /tmp/yarn-site.xml $HADOOP_HOME/conf/yarn-site.xml && \  # disable Yarn configs for hadoop 1.2.1
    mv /tmp/slaves $HADOOP_HOME/conf/slaves && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh

RUN chmod +x ~/start-hadoop.sh && \
    #chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/bin/start-all.sh
    # chmod +x $HADOOP_HOME/bin/start-yarn.sh   #FIXME? Where is this on hadoop 1.2.1  (disabled for 1.2.1)

# format namenode
RUN $HADOOP_HOME/bin/hadoop namenode -format

CMD [ "sh", "-c", "service ssh start; bash"]
