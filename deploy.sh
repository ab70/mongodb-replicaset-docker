#!/bin/bash
# if can't access through the compass then add this:
# /etc/hosts: localhost mongo1

# 1. Run setup.sh
# bash setup.sh

# # 2. Start Docker containers
# docker compose down
# docker compose up -d

# # 3. Execute commands inside mongo1 container
# docker exec -it mongo1 bash

# # 4. Connect to MongoDB shell
# mongosh -u root -p example

# # 5. Initialize replica set
# rs.initiate(
#   {
#     _id: "rs0",
#     version: 1,
#     members: [
#       { _id: 0, host: "mongo1:27017" },
#       { _id: 1, host: "mongo2:27018" },
#       { _id: 2, host: "mongo3:27019" }
#     ]
#   }
# )

# # 6. Check replica set status
# rs.status()

# Automate full things of above commands
# 1. Run setup.sh
bash setup.sh

# 2. Start Docker containers
docker compose down
docker compose up -d

# 3. Execute commands inside mongo1 container
docker exec -it mongo1 bash -c 'mongosh -u root -p example --eval "rs.initiate({ _id: \"rs0\", version: 1, members: [ { _id: 0, host: \"mongo1:27017\" }, { _id: 1, host: \"mongo2:27018\" }, { _id: 2, host: \"mongo3:27019\" } ] })"'

# Wait for a few seconds to allow replica set initialization
sleep 10

# Check replica set status
docker exec -it mongo1 bash -c 'mongosh -u root -p example --eval "rs.status()"'

