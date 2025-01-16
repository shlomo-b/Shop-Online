# Use slim variant for smaller image size
FROM python:3.12.0-slim

# Set working directory
WORKDIR /app

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
RUN rm MONGO_DB_HOST MONGO_DB_PASSWORD MONGO_DB_USERNAME 

# Expose port
EXPOSE 5050

# Start application
CMD ["python", "app.py"]
