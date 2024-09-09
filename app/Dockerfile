# Use an official Python 
FROM python

# Set the working directory the on the container 
WORKDIR /app 

# Copy the requirements file first
COPY app/requisites.txt /app/
RUN pip install --upgrade pip

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requisites.txt

# Copy the rest of the application files
COPY app /app
 
# Make port 80 available to the world outside this container
EXPOSE 80

# dasdsad
COPY /app/main.py /app

# Run app.py when the container launches
CMD ["python" , "main.py"]

