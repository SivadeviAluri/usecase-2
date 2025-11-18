FROM ubuntu:22.04
RUN apt update -y
RUN apt install openjdk-21-jdk -y
WORKDIR /app
COPY calculator-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8081
CMD ["java", "-jar", "app.jar"]
