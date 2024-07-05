# Docker Tutorial 12

Mongo cluster, deploying a ReplicaSet

### To run the cluster:
```
docker-compose up
```

### Connect to the primary node
```
docker-compose exec mongo1 mongo -u root -p password
```

### Instantiate the replica set
```
rs.initiate({"_id" : "rs0","members" : [{"_id" : 0,"host" : "mongo1:27017"},{"_id" : 2,"host" : "mongo2:27017"},{"_id" : 3,"host" : "mongo3:27017"}]});
```
### In this point there will be 3 secondary node now to vote for mongo1
### Set the priority of the master over the other nodes
```
conf = rs.config();
conf.members[0].priority = 2;
rs.reconfig(conf);
```

### Create a cluster admin
```
use admin;
db.createUser({user: "cluster_admin",pwd: "password",roles: [ { role: "userAdminAnyDatabase", db: "admin" },  { "role" : "clusterAdmin", "db" : "admin" } ]});
db.auth("cluster_admin", "password");
```

### Create a collection on a database
```
use my_data;
db.createUser({user: "my_user",pwd: "password",roles: [ { role: "readWrite", db: "my_data" } ]});
db.createCollection('my_collection');
```

### Verify credentials
```
docker-compose exec mongo1 mongosh -u my_user -p password --authenticationDatabase my_data
```

### Destory the cluster
```
docker-compose down
```

### go to /etc/hosts and do:
```
127.0.0.1   localhost   mongo1  mongo2  mongo3
```
### connection url:
```
mongodb://root:password@localhost:27017,localhost:27018,localhost:27019/?replicaSet=rs0&authSource=admin
```