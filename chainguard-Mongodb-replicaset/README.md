# MongoDB Replica Set Setup with Authentication (chainguard image)

This guide provides steps to set up a MongoDB replica set with authentication and troubleshoot common issues.

## Prerequisites
- Docker installed
- MongoDB Docker containers (`mongo1`, `mongo2`, `mongo3`) running by
```
docker compose up -d
```

## 1. Initial Replica Set Configuration

### Connect to the primary node (mongo1) without authentication:
```bash
docker exec -it mongo1 mongo
```
### Initiate repluca
```
rs.initiate()
```

### Add secondary sets
```
rs.add("mongo2:27017")
rs.add("mongo3:27017")
```

#### Check replica statsu (optional)
```
rs.status()
```

### Setting up authentication
```
use admin
db.createUser({
  user: "admin",
  pwd: "password",
  roles: [{ role: "root", db: "admin" }]
})
```
```
exit
```

### Connect by authenticatiig
```
docker exec -it mongo1 mongo -u admin -p password --authenticationDatabase admin
```
