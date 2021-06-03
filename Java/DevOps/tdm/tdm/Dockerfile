# openjdk:11-jre-slim is the image
FROM openjdk:11.0-jre-slim

# changes working directory. created if it does not exist
WORKDIR /app

# copies the jar and directories to the current directory
COPY ./target/*-SNAPSHOT.jar .

# exposes app to port 8080
EXPOSE 8080

# read as "java -jar tdm-0.0.1-SNAPSHOT.jar", effectively running the jar file on container startup
ENTRYPOINT ["java", "-jar", "tdm-0.0.1-SNAPSHOT.jar"]
