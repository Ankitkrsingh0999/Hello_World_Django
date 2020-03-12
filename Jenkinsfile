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
    stage('DockerHub') {
	agent any
        environment {
            registry = "ankit0999/docker-test"
            registryCredential = "dockerhub"
        }
       steps {
	 git 'https://github.com/Ankitkrsingh0999/Hello_World_Django.git'
       }
    }	    
    stage('Build Image') {
      steps{
        script {
          dockerImage = docker.build("ankit0999/docker-test")
        }
      }
    }
    stage('Build Preparation') {
      environment 
      {
	AWS_BIN = '/home/ec2-user/.local/bin/aws'
      }
      steps{
        script {
	  docker.withRegistry('http://055958952830.dkr.ecr.ap-south-1.amazonaws.com/demo','ecr:ap-south-1:ECS-Credentials' )
	  {
	      sh 'docker tag demo:latest 055958952830.dkr.ecr.ap-south-1.amazonaws.com/demo:latest'
              sh 'docker push ankit0999/docker-test'
	  }
	}
      }
    }
  }
}
