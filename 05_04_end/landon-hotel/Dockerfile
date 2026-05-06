FROM maven:3.9.4-eclipse-temurin-20 AS build
WORKDIR /workspace

# Copy Maven files and source
COPY pom.xml ./
COPY src ./src

# Build the application jar
RUN mvn -B -DskipTests package
RUN mkdir -p /workspace/dist && cp target/*.jar /workspace/dist/app.jar

FROM eclipse-temurin:20-jre
WORKDIR /app
COPY --from=build /workspace/dist/app.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
