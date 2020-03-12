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
    stage('Deploy Image') {
      environment 
      {

        VERSION = 'latest'

        PROJECT = 'docker-test'

        IMAGE = 'docker-test:latest'

        ECRURL = 'http://055958952830.dkr.ecr.ap-south-1.amazonaws.com/demo'

        ECRCRED = 'ecr:ap-south-1:ECR-Credentials'

      }
    }

    stage('Build preparations')
    {
      steps
      {
        script 
        {
            gitCommitHash = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
            shortCommitHash = gitCommitHash.take(7)
            VERSION = shortCommitHash
            currentBuild.displayName = "#${BUILD_ID}-${VERSION}"
            IMAGE = "$PROJECT:$VERSION"
        }
      }
    }
    stage('Deploy Image'){
      steps{
        script {
	  sh("eval \$(aws ecr get-login --no-include-email | sed 's|https://||')")
	  docker.withRegistry(ECRURL, ECRCRED)
	  {
              docker.image(IMAGE).push()
	  }
	}
      }
    }
  }
}
