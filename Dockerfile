# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim

# Set working directory
WORKDIR /app

# Copy application JAR file
COPY target/my-java-app-1.0-SNAPSHOT.jar app.jar

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
