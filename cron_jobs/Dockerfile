# Use uma imagem de python como base
FROM python:3.11

# Set the working directory in the container
WORKDIR /app

# Install cron for time job
RUN apt-get update && apt-get -y install cron

# Define an environment variable for the scripts path
#ENV SCRIPTS_PATH /home/pi/docker/vscode/config/workspace/bot_scripts

# Create a symbolic link to the scripts folder outside the container
#RUN ln -s  $SCRIPTS_PATH /app/scripts

RUN pip install --upgrade pip

# Install any needed packages specified in requirements
#COPY $SCRIPTS_PATH/requirements.txt /app/scripts/requirements.txt
RUN pip install -r /app/scripts/requirements.txt

# Copy the croapp/script
RUN ln -s /app/scripts/crontab /etc/cron.d/mycron

# Give execution rights on the cronjob
#RUN chmod 0644 /etc/cron.d/mycron

# Run the cron proce# Run the cron process
CMD ["cron", "-f"]
