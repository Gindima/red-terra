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
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    powershell 'docker-compose up -u $USERNAME -p $PASSWORD'
                }
            }
        }
    }
}
