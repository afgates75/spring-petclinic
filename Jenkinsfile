pipeline {
    agent any
    options {
        buildDiscarder (logRotator (numToKeepStr: '5'))
    		}
    environment {
    			DOCKERHUB_CREDENTIALS = credentials('dockerhub')
  				}
  stages {
  		stage('Test') {
      				steps {
        					sh(script: './mvnw --batch-mode -Dmaven.test.failure.ignore=true test')
           					echo 'Running JUnit Tests'
      						}
   						}
   		stage('Package') {
      				steps {
       						 sh(script: './mvnw --batch-mode package -DskipTests')
       						 echo 'Execute Maven Project'
      						}
    					}
    	stage('Build') {
      				steps {
        					sh 'docker build -t afgates75/spring-petclinic-docker2 .'
      						}
    					}
		stage('Login') {
      				steps {
        					sh 'echo $DOCKERHUB_CREDENTIALS | docker login -u afgates75 --password-stdin'
        					echo 'Login to Docker Hub'
      						}
    					}
		stage('Push') {
      				steps {
        					sh 'docker push afgates75/spring-petclinic-docker2'
        					echo  'Push Docker Image to Docker Hub'
      						}
    					}
  		}
  post {
	always {
    	sh 'docker logout'
    	junit(testResults: 'target/surefire-reports/*.xml', allowEmptyResults : true)
    		}
  		}
}
