pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Gindima/alibaba.git', branch: 'master'
            }
        }

        stage('Exécuter docker-compose up') {
            steps {
                // Check if docker-compose is available (optional)
                sh 'docker-compose ps'

                // Assuming docker-compose is a wrapper for docker commands
                sh 'docker-compose up -d'
            }
        }
    }
}
