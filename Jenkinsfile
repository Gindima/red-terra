pipeline {
  agent any
  stages {
   
    stage ('test') {
      steps {
        bat 'docker ps -a'
      }
    }
    stage ('Run Docker Compose') {
      steps {
        sh 'docker-compose up  -d'
      }
    }
  }
  post {
    success {
      slackSend channel: 'groupe4', message: 'Code execute'
    }
    failure {
      slackSend channel: 'groupe4', message: 'Code execute with error'
    }
  }
}