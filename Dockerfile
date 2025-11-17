FROM ubuntu
WORKDIR /data
COPY target/calculator-0.0.1-SNAPSHOT.jar  /devi.jar
EXPOSE 8081
CMD ["java","-jar","/devi.jar"]
