# 1. Build stage: Use the official Maven image (includes JDK 8)
FROM maven:3.8-jdk-8 AS builder
WORKDIR /app/source
COPY . .
RUN mvn clean package

# 2. Runtime stage: Use a lightweight JRE image
FROM eclipse-temurin:8-jre-alpine
WORKDIR /app
# Copy ONLY the built jar from the builder stage
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]
