pipeline {
    agent any
    options {
        buildDiscarder (logRotator (numToKeepStr: '5'))
    		}
    environment {
    			ARTIFACTORY_CREDENTIALS = credentials('artifactory')
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
		stage('Artifactory') {
      				steps {
        					sh 'echo $ARTIFACTORY_CREDENTIALS | docker login -uafgates@gmail.com andrewgates.jfrog.io --password-stdin'
        					
        					echo 'Login to Artifactory Hub'
      						}
    					}
		stage('Push') {
      				steps {
        					sh 'docker push andrewgates.jfrog.io/spring-petclinic-docker/spring-petclinic-docker:1.0.0'
        					echo  'Push Docker Image to Artifactory'
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
