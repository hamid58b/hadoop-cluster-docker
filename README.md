## Run Hadoop Cluster within Docker Containers

### 3 Nodes Hadoop Cluster

<!-- ##### 1. pull docker image

```
sudo docker pull docker push hamidb/hadoop-1x-cluster:latest

``` -->

#####  clone Github repository

```
git clone https://github.com/hamid58b/hadoop-cluster-docker.git
```

##### create hadoop network

```
sudo docker network create --driver=bridge hadoop
```

##### build docker container
```
docker build -t docker-hadoop-1.2.1 .
```


#####  start container

```
cd hadoop-cluster-docker
sudo ./start-container.sh
```

**output:**

```
start hadoop-master container...
start hadoop-slave1 container...
start hadoop-slave2 container...
root@hadoop-master:~#
```
- start 3 containers with 1 master and 2 slaves
- you will get into the /root directory of hadoop-master container
- see the start-container.sh file. The ```-v ~/Documents/:/docs \``` argument shows that the ~/Documents folder on the host will be mapped to the /docs/ on the containers. You can modify this folder accordingly.

##### start hadoop

```
./start-hadoop.sh
```

##### Run Boa query on hadoop
```
hadoop jar /path/to/the/jarfile/Query.jar boa.Query /repcache/liveg/  /tmp/output_01

```
- Note that the last 2 arguments are paths on the hadoop ```/repcache/liveg/``` is the path of dataset  
and ```/tmp/output_01``` would be the path of the Boa output
- Before running the Boa query you need to put the *.seq files in the ```/repcache/liveg/``` folder on the hadoop by
  - ``` hadoop fs -put /path/to/the/seq_files  /repcache/liveg/```



<!-- ### Arbitrary size Hadoop cluster

##### 1. pull docker images and clone github repository

do 1~3 like section A

##### 2. rebuild docker image

```
sudo ./resize-cluster.sh 5
```
- specify parameter > 1: 2, 3..
- this script just rebuild hadoop image with different **slaves** file, which pecifies the name of all slave nodes


##### 3. start container

```
sudo ./start-container.sh 5
```
- use the same parameter as the step 2

##### 4. run hadoop cluster

do 5~6 like section A -->
