## mongodb-replicaset
## 1. Run setup.sh
```
bash setup.sh
```
## 2. Start Docker containers
```
docker compose down
docker compose up -d
```
## 3. Execute commands inside mongo1 container
```
docker exec -it mongo1 bash
```
## 4. Connect to MongoDB shell
```
mongosh -u root -p example
```
## 5. Initialize replica set
```
rs.initiate(
  {
    _id: "rs0",
    version: 1,
    members: [
      { _id: 0, host: "mongo1:27017" },
      { _id: 1, host: "mongo2:27018" },
      { _id: 2, host: "mongo3:27019" }
    ]
  }
) 
```

## 6. Check replica set status
```
rs.status()
```

## Connect using compass
## Url
```
mongodb://root:example@localhost:27017,localhost:27018,localhost:27019/?replicaSet=rs0&authSource=admin
```
If youu can't connect and it keeps loading then for Linux :
```
sudo nano /etc/hosts
```
Add or modify 127.0.0.1 localhost , then add container name for example:
```
127.0.0.1   localhost   mongo1
```
Then save & exit. Now with the url it is accessable.

## Automate Full Deployment
#### This will work if if have initialized the whole process once (Initially it fails for delay issue which can vary from matchine to matchine).
```
sudo bash deploy.sh
```