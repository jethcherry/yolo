# Use a base image with Node.js
FROM node:14

# Set environment variables for OpenSSL legacy provider
ENV NODE_OPTIONS=--openssl-legacy-provider

# Frontend stage
WORKDIR /app/frontend
COPY client/package*.json ./
RUN npm install
COPY client ./
RUN npm run build

# Backend stage
WORKDIR /app/backend
COPY backend/package*.json ./
RUN npm install
COPY backend ./

# Copy MongoDB data directory (Optional, if you want to include initial data)
COPY mongo-data /data/db

# Install MongoDB
RUN apt-get update && apt-get install -y mongodb

# Create a directory for MongoDB data
RUN mkdir -p /data/db

# Copy the start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose necessary ports
EXPOSE 3000 5000 27017

# Start all services
CMD ["/start.sh"]
