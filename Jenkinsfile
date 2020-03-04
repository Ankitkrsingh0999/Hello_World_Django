pipeline {
  agent any
  stages {
    stage('test') {
      steps {
        slackSend(message: 'test', baseUrl: 'https://hooks.slack.com/services/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', botUser: true)
      }
    }
    stage("Build and Sonarqube analysis") {
      agent any 
      steps {
	withSonarQubeEnv('sonarserver') {
	  sh '/opt/sonarqube/bin/linux-x86-64'
	}
      }
    }
    stage ("Quality Gate") {
      steps {
 	timeout(time: 1, unit: 'HOURS') {
	  waitForQualityGate abortPipeline: true
	}
      }
    }
  }
}
