# Use the official Node.js image as the base image
FROM node:16.14.0-alpine 

#This image should be used if you are using a M1 Mac
# FROM  --platform=linux/amd64 node:16.14.0-alpine

# Setting up  the working directory
WORKDIR /usr/src/app

# Addint the app 
COPY package*.json ./

# Installing dependencies
RUN npm install

# Copying the application files
COPY . .

# Exposinga the port
EXPOSE 3000

# Start the app!
CMD [ "node", "app.js" ]
