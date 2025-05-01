FROM openjdk:17-jdk-alpine

# Set the working directory inside the container

# Copy the application's jar to the container
ADD target/loginApp-0.0.1-SNAPSHOT.jar loginapp

# Expose port 8081 to the outside world
EXPOSE 8088

# Run the jar file
ENTRYPOINT ["java", "-jar", "loginapp"]