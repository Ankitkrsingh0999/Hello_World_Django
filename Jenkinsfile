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
    stage("Build and Sonarqube analysis") {
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
      steps {
        withDockerRegistry([ credentialsId: "dockerhub", url: "https://hub.docker.com/repository/docker/ankit0999/hello_world_devops" ]) {
      // following commands will be executed within logged docker registry
          sh 'docker push <ankit0999/hello_world_devops>'
        }
      }
    }	    
  }
}
