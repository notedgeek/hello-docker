FROM maven:3.6.0-jdk-8 as maven
COPY ./pom.xml ./pom.xml
RUN mvn dependency:go-offline -B

COPY ./src ./src
RUN mvn package -DskipTests

FROM openjdk:8-jre-alpine
WORKDIR /my-project
COPY --from=maven target/hello-docker-1.0-SNAPSHOT-jar-with-dependencies.jar ./
CMD ["java", "-jar", "./hello-docker-1.0-SNAPSHOT-jar-with-dependencies.jar"]
