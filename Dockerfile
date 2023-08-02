FROM anapsix/alpine-java
LABEL maintainer="afgates@gmail.com"
COPY /target/spring-petclinic-3.1.0-SNAPSHOT.jar /home/spring-petclinic-3.1.0-SNAPSHOT.jar 
CMD ["java","-jar","/home/spring-petclinic-3.1.0-SNAPSHOT.jar"]