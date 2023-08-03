pipeline {
    agent any
    tools {
    	jfrog 'jfrog-cli'
    	}   		
	environment {
    			ARTIFACTORY_CREDENTIALS = credentials('artifactory')
    			DOCKER_IMAGE_NAME = "andrewgates.jfrog.io/spring-petclinic-docker/spring-petclinic"
  				}
  	stages {
  		stage('Checkout') {
                    steps {
                        script {
                            checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/afgates75/spring-petclinic.git']]])
                            echo 'Checking out code from GitHub'
                                }
                            }
                        }
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
        					sh 'docker build -t "$DOCKER_IMAGE_NAME" .'
      						}
    					}
		stage('Scan and Push') {
      				steps {
        					dir(''){
        					sh 'echo $ARTIFACTORY_CREDENTIALS | docker login -uafgates@gmail.com andrewgates.jfrog.io --password-stdin'
        					echo 'Login to Artifactory Hub'
        					
        					jf 'docker scan $DOCKER_IMAGE_NAME'
        					jf 'docker push $DOCKER_IMAGE_NAME'   					

        					echo  'Scan and push Docker Image'
      						}
    					}}		
    	stage('Publish build info') {
      				steps {
        					jf 'rt build-publish'
        					echo  'Publish build info to Artifactory'
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
