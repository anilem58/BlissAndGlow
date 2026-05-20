# Multi-stage Dockerfile for BlissAndGlow

# Build stage
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /build

# Copy Maven config and source
COPY pom.xml .
COPY src ./src
COPY database ./database

# Build the application
RUN mvn clean package -DskipTests

# Runtime stage
FROM tomcat:10.1-jdk17-eclipse-temurin

# Set environment variables
ENV CATALINA_HOME=/usr/local/tomcat
ENV JAVA_OPTS="-Djava.awt.headless=true -Dfile.encoding=UTF-8"

# Remove default webapps
RUN rm -rf $CATALINA_HOME/webapps/*

# Copy WAR from builder
COPY --from=builder /build/target/blissandglow.war $CATALINA_HOME/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]
