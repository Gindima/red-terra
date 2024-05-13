pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    bat "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                    bat 'docker build -t ligne-rouge-web -f App.Dockerfile .'
                    bat 'docker build -t ligne-rouge-db -f Db.Dockerfile .'
                    bat 'docker push ligne-rouge-web'
                    bat 'docker push ligne-rouge-db'
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                // Utilisez kubectl pour déployer sur votre cluster Kubernetes
                dir('kubernetes') {
                    bat 'kubectl apply -f db-deployment.yaml'
                    bat 'kubectl apply -f web-deployment.yaml'
                }
            }
        }
    }
}
