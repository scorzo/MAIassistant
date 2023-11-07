# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the Python script into the container at /usr/src/app
COPY MAI_revolt.py ./
COPY secure.ini ./

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir revolt.py langchain configparser

# Run bot.py when the container launches
CMD ["python", "./MAI_revolt.py"]
