                                                                          
# Use an official Ubuntu base image
FROM ubuntu:latest

# Update package list and install required packages
RUN apt-get update -y && \
    apt-get install -y apache2 \
    python3 \
    python3-pip

# Check if Python and pip are installed correctly
RUN python3 --version && pip3 --version
    
# Install prometheus_client
RUN pip3 install prometheus_client

# Remove existing content in /var/www/html
RUN rm -rf /var/www/html/*    # this is important 

# Copy your existing index.html file into the container
COPY  /app/blackjack.html  /var/www/html/index.html

# Create a script to start Apache
RUN echo '#!/bin/bash' > /root/run_apache.sh && \
    echo 'mkdir -p /var/run/httpd' >> /root/run_apache.sh && \
    echo 'mkdir -p /var/lock/httpd' >> /root/run_apache.sh && \
    echo '/usr/sbin/apache2ctl -D FOREGROUND' >> /root/run_apache.sh && \
    chmod +x /root/run_apache.sh

# Expose port 80
EXPOSE 80

# Start Apache using the script
CMD ["/root/run_apache.sh"]















