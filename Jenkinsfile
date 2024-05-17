pipeline {
    agent any
    environment {
        DOCKER_USERNAME = credentials('docker-hub-creds').username
        DOCKER_PASSWORD = credentials('docker-hub-creds').password
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Construction des images Docker') {
            steps {
                script {
                    def webImageExists = bat(script: "docker images -q ${DOCKER_USERNAME}/ligne-rouge-web", returnStatus: true) == 0
                    def dbImageExists = bat(script: "docker images -q ${DOCKER_USERNAME}/ligne-rouge-db", returnStatus: true) == 0
                    
                    if (webImageExists) {
                        bat "docker rmi ${DOCKER_USERNAME}/ligne-rouge-web"
                    }
                    if (dbImageExists) {
                        bat "docker rmi ${DOCKER_USERNAME}/ligne-rouge-db"
                    }
                    
                    bat 'docker-compose build'
                }
            }
        }
        stage('Build and Push Docker Images') {
            steps {
                script {
                    // Tag des images
                    bat "docker tag ligne-rouge-web ${DOCKER_USERNAME}/ligne-rouge-web"
                    bat "docker tag ligne-rouge-db ${DOCKER_USERNAME}/ligne-rouge-db"
                    
                    // Connexion à Docker Hub et push des images
                    bat "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                    bat "docker push ${DOCKER_USERNAME}/ligne-rouge-web"
                    bat "docker push ${DOCKER_USERNAME}/ligne-rouge-db"
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
