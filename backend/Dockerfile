# Use Node.js 18 Alpine as base image
FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install production dependencies only
RUN npm ci --only=production

# Copy application source code
COPY . .

# Set environment to production
ENV NODE_ENV=production

# Expose port 8080
EXPOSE 8080

# Start the application
CMD ["node", "server.js"]
