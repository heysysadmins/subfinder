# 🛠 Stage 1: Build subfinder from source
FROM golang:1.21 as builder

# Install subfinder CLI
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# 🧪 Stage 2: Final Node.js image
FROM node:18

# Copy subfinder binary from the Go builder stage
COPY --from=builder /go/bin/subfinder /usr/local/bin/subfinder

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy app source
COPY . .

# Expose the port (used by Express)
EXPOSE 3000

# Run the Node.js server
CMD ["npm", "start"]
