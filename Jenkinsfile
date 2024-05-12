pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build and Dockerize') {
            steps {
                bat 'docker-compose up'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    bat "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                    bat 'docker-compose push'
                }
            }
        }
    }
}
