# loginApp

HOW TO DEPLOY JAVA APP TO EC2 USING DOCKER FILE AND DOCKER_COMPOSE
=====================================================================

Deploying your Java application using Docker Compose on an EC2 instance is a great way to ensure consistency and scalability. Here’s a step-by-step guide to help you through the process:
-----------------------
Step 1: Prepare Your Java Application
Ensure your Java application is ready for containerization. You should have a Dockerfile in your project directory. Here’s a simple example of a Dockerfile for a Spring Boot application:


# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the jar file into the container
COPY target/myapp.jar /app/myapp.jar

# Run the jar file
ENTRYPOINT ["java", "-jar", "/app/myapp.jar"]
--------------------------
Step 2: Create a Docker Compose File
Create a docker-compose.yml file in your project directory. This file will define the services, networks, and volumes for your application. Here’s an example:


version: '3.8'

services:
  myapp:
    image: myapp:latest
    build: .
    ports:
      - "8080:8080"
    environment:
      - SPRING_PROFILES_ACTIVE=prod
---------------------------	  
	  
Step 3: Build and Test Locally
Before deploying to EC2, build and test your Docker images locally:


docker-compose build
docker-compose up
Ensure everything works as expected.
---------------------------

Step 4: Set Up Your EC2 Instance
Launch an EC2 Instance: Choose an appropriate instance type and configure security groups to allow SSH (port 22) and your application port (e.g., 8080).

Install Docker and Docker Compose:


sudo apt-get update
sudo apt-get install -y docker.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
---------------------------------------------
Step 5: Transfer Files to EC2
Use scp or any other secure method to transfer your project files, including the Dockerfile and docker-compose.yml, to your EC2 instance.


scp -i /path/to/your-key.pem -r /path/to/your/project ec2-user@your-ec2-ip:/home/ec2-user/
Step 6: Deploy on EC2
SSH into your EC2 instance and navigate to your project directory:


ssh -i /path/to/your-key.pem ec2-user@your-ec2-ip
cd /home/ec2-user/your-project-directory
Build and run your Docker containers using Docker Compose:


sudo docker-compose build
sudo docker-compose up -d
-------------------------------------
Step 7: Verify Deployment
Check the status of your containers:


sudo docker-compose ps
Access your application via the EC2 instance's public IP and the exposed port (e.g., http://your-ec2-ip:8080).

Conclusion
By following these steps, you should have your Java application deployed using Docker Compose on an EC2 instance. This setup ensures that your application is containerized, making it easier to manage and scale. If you encounter any issues, feel free to reach out for further assistance. Happy deploying!

