pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '3'))
  }
  stages {
    stage('test') {
      steps {
        slackSend(message: 'test', baseUrl: 'https://hooks.slack.com/services/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', botUser: true)
      }
    }
    stage('Sonarqube') {
        environment {
            scannerHome = tool 'sonar-scanner'
        }    
	steps {
             withSonarQubeEnv('sonarserver') {
                 sh "${scannerHome}/bin/sonar-scanner"
             }        
       }
    }
    stage('Build image') {	  
        environment {
            registry = "ankit0999/docker-test:latest"
            registryCredential = "dockerhub"
        }
        steps{
            script {
              docker.build registry + ":$BUILD_NUMBER"
            }
        }
    }	    
  }
}
