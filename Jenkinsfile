#!groovy
pipeline {
	agent none
  stages {
  	stage('Maven Install') {
    	agent {
      	docker {
        	image 'maven:3.9.3'
        }
      }
      steps {
      	sh 'mvn clean install'
      }
    }
  }
}
