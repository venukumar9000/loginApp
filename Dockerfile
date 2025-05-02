# Stage 1: Build the JAR using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

# Stage 2: Run the application using OpenJDK
FROM openjdk:17-jdk-alpine

WORKDIR /app

COPY --from=builder /app/target/loginApp-0.0.1-SNAPSHOT.jar loginapp.jar

EXPOSE 8088

ENTRYPOINT ["java", "-jar", "loginapp.jar", "--spring.profiles.active=docker"]
