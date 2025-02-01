# Step 1: Set up the build environment using Node.js
FROM node:18 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json (if available) first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project into the container
COPY . .

# Build the React app
RUN npm run build

# Step 2: Set up the production environment
FROM nginx:alpine

# Copy the build files from the build stage to Nginx's public folder
COPY --from=build /app/dist /usr/share/nginx/html

# Expose the default port for Nginx
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
