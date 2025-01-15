# Use slim variant for smaller image size
FROM python:3.12.0-slim

COPY shop-online-app/backend/.env .

# Set environment variables for MongoDB connection
ENV MONGO_DB_USERNAME=${MONGO_DB_USERNAME} \
    MONGO_DB_PASSWORD=${MONGO_DB_PASSWORD} \
    MONGO_DB_HOST=${MONGO_DB_HOST}

# Copy requirements first to leverage Docker cache
COPY shop-online-app/backend/requirements.txt .

# Install dependencies in a single RUN command to reduce layers
# Clean up apt cache to reduce image size
RUN pip install --no-cache-dir -r requirements.txt && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
        curl \
        iputils-ping \
        net-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy application code
COPY shop-online-app/backend/app.py .

# Remove .env file
RUN rm .env

# Expose port
EXPOSE 5050

# Start application
CMD ["python", "app.py"]
