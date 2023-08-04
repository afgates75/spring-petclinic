# Spring PetClinic Sample Application [![Build Status](https://github.com/spring-projects/spring-petclinic/actions/workflows/maven-build.yml/badge.svg)](https://github.com/spring-projects/spring-petclinic/actions/workflows/maven-build.yml)

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/spring-projects/spring-petclinic) [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=7517918)

The Jenkinsfile included was designed as a code-first sample, rather than using Jenkins
graphical build steps. Required plugins include GitSCM, JFrog CLI, Docker Pipeline and 
Credentials plugin. Secrets for Artifcatory, GitHub, and Docker Hub are stored in the 
Credentials plugin independent of the Jenkinsfile code.

The application is initially pushed from a local instance  and a Jenkins pipeline is used 
to checkout this repository. Then Jenkins will run JUnit tests against the code, use Maven
to check and update all dependenceies, and create a docker image. Due to constraints of 
using Mac OSX, a docker shell script is required for the build process, but the JFrog CLI 
is used for all other tasks. JFrog CLI will log into Artifactory and the docker image 
will be scanned by XRay. Finally,the docker image will be pushed to the Docker Repository 
on JFrog and publishing information will be updated.

Included also is a Dockerfile that is designed to use eclipse-temurin:17-jdk-jammy as an
image base, then multiple images are used to build the most efficient docker image, 
cutting the size of the Tomcat and MySQL instances from 650 MB to 315 MB.

The latest docker image is stored at andrewgates.jfrog.io

The commands to pull down and use the image are as follows:

docker login

docker pull andrewgates.jfrog.io/spring-petclinic-docker-local/spring-petclinic:latest

docker run -it -p 8080:8080 andrewgates.jfrog.io/spring-petclinic-docker/spring-petclinic

To access the petclinic application:

http://localhost:8080

To pull some sample data via a REST API:

curl --request GET --url http://localhost:8080/vets --header 'content-type: application/json'
