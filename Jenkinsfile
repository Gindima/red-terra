pipeline {
    agent any

    stages {
        stage('Récupérer le code depuis GitHub') {
            steps {
                git url: 'https://github.com/Gindima/alibaba.git', branch: 'main'
            }
        }
        stage('Exécuter docker-compose up') {
            steps {
                // Check if docker-compose is available (optional)
                bat 'docker-compose up'
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    bat 'docker-compose up -d --username $USERNAME --password $PASSWORD'
                }
            }
        }
    }
}
