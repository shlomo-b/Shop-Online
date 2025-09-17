FROM node

WORKDIR /app

# Install dependencies first (better caching)
COPY shop-online-app/frontend/package*.json ./
RUN npm ci --silent

# Required for Create React App's development mode in container
ENV CI=true
ENV WDS_SOCKET_PORT=0
ENV CHOKIDAR_USEPOLLING=true

# Environment variable for backend URL
# Note: This will be overridden by docker-compose environment settings (see docker-compose.override.yml)
ENV REACT_APP_API_URL=http://localhost:5050

# Install development tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Copy application files
COPY shop-online-app/frontend .

# Expose port
EXPOSE 3000

# Start development server with host set to 0.0.0.0 - tedג
CMD ["npm", "start"]