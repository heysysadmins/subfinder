# Stage 1: Build subfinder CLI
FROM golang:1.21 AS builder

RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Verify subfinder binary exists
RUN ls -l /go/bin/subfinder

# Stage 2: Final image with Node.js + subfinder
FROM node:18

# Copy subfinder binary from builder stage
COPY --from=builder /go/bin/subfinder /usr/local/bin/subfinder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
