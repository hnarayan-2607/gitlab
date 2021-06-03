### STAGE 1: Compile and Build angular codebase ###

# Use official node image as the base image
FROM node:14.15-alpine AS build

# Set environment variable
ENV NODE_ENV=qa

# Set the working directory
WORKDIR /usr/src/app

# Add the package json files to /usr/src/app
COPY package*.json ./

# Install all the dependencies
RUN npm install

# Copy all the dependencies with the source code to /usr/src/app
COPY . ./

# Generate the build of the application for the QA profile
RUN npm run build --$NODE_ENV



### STAGE 2: Serve app with nginx server ###

# Use official nginx image as the base image
# FROM nginx:nginx:1.20-alpine
FROM nginx:1.20-alpine

# Expose port 4200 default port
EXPOSE 4200

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Copy the build output to replace the default nginx contents.
COPY --from=build /usr/src/app/dist/testautomation /usr/share/nginx/html
