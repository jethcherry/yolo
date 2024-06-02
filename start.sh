#!/bin/bash

# Start MongoDB
mongod --fork --logpath /var/log/mongodb.log --dbpath /data/db

# Start Backend
cd /app/backend
npm start &

# Start Frontend
cd /app/frontend
npm run serve &
# or if using a different command, adjust accordingly

# Wait and keep container running
wait
