# Use an official Python 
FROM python:3.9-slim

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

# copy the file main.py
COPY /app/main.py /app

# COPY . = copy all the files from folder app , cope . . = copy all the filies to container app

# Run app.py when the container launches
CMD ["python" , "main.py"]

# ENTRYPOINT ["python" , "main.py"] @ to work only with python and not with bash or sh or any other shell