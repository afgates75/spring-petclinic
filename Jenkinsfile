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
           					// echo 'Testing'
      					}
   						}
   		 stage('Package') {
      				steps {
       						 sh(script: './mvnw --batch-mode package -DskipTests')
      						}
    					}
    stage('Build') {
      steps {
        sh 'docker build -t afgates75/spring-petclinic-docker2 .'
      }
    }
    stage('Login Docker Hub') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS | docker login -u afgates75 --password-stdin'
      }
    }
    stage('Push Docker Hub') {
      steps {
        sh 'docker push afgates75/spring-petclinic-docker2'
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
