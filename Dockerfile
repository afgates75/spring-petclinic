FROM anapsix/alpine-java
LABEL maintainer="afgates@gmail.com"
COPY /Users/afgates/.jenkins/workspace/spring-petclinic/target/spring-petclinic-3.1.0-SNAPSHOT.jar /Users/afgates/home/spring-petclinic-3.1.0-SNAPSHOT.jar 
CMD ["java","-jar","/Users/afgates/home/spring-petclinic-3.1.0-SNAPSHOT.jar"]
