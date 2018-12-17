#!/bin/bash

mv /tmp/hadoop-root/dfs/name/current /tmp/hadoop-root/dfs/name/lastcheckpoint.tmp

echo -e "\n"

$HADOOP_HOME/bin/start-all.sh

echo -e "\n"

hadoop fs -mkdir /repcache/

echo -e "\n"

hadoop fs -mkdir /repcache/liveg/

echo -e "\n"

#$HADOOP_HOME/bin/start-yarn.sh  #FIXME: remove for 1.2.1 Hadoop
# echo -e "\n"
