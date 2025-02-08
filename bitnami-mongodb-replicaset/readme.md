### Initail command 
```
docker compose up -d
```

### Get into mongo1 container
```
 docker exec -it mongo1 bash

```
### MongoDB auth in mongo1
```
 mongosh -u root -p password123
```

### Check mongodb replicaset status
```
rs.status()
```

### initiate document
```
rs.initiate({
  _id: "replicaset",
  members: [
    { _id: 0, host: "mongo1:27017" },
    { _id: 1, host: "mongo2:27017" },
    { _id: 2, host: "mongo3:27017", arbiterOnly: true }
  ]
});
```
### go to /etc/hosts and do:
```
127.0.0.1   localhost   mongo1  mongo2  mongo3
```
### connection url:
```
mongodb://root:password123@mongo1:27017,mongo2:27017,mongo3:27017/?replicaSet=replicaset&authSource=admin
```
