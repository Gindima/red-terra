pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS = credentials('docker-hub-creds')
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
                    def webImageExists = bat(script: "docker images -q red-line-web", returnStatus: true) == 0
                    def dbImageExists = bat(script: "docker images -q red-line-db", returnStatus: true) == 0
                    
                    if (webImageExists) {
                        bat "docker rmi red-line-web"
                    }
                    if (dbImageExists) {
                        bat "docker rmi red-line-db"
                    }
                    
                    bat 'docker-compose build'
                }
            }
        }
        
        stage('Build and Push Docker Images') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        // Tag des images
                        powershell "docker tag red-line-web ${DOCKER_USERNAME}/red-line-web"
                        powershell "docker tag red-line-db ${DOCKER_USERNAME}/red-line-db"
                        
                        // Connexion à Docker Hub et push des images
                        powershell "docker login -u ${DOCKER_USERNAME} --password-stdin ${DOCKER_PASSWORD}"
                        powershell "docker push ${DOCKER_USERNAME}/red-line-web"
                        powershell "docker push ${DOCKER_USERNAME}/red-line-db"
                    }
                }
            }
        }
        stage('Déploiement sur Kubernetes') {
            steps {
                script {
                    // Naviguer dans le dossier Kubernetes
                    dir('alibaba/kubernetes') {
                        // Appliquer les fichiers YAML
                        bat 'kubectl apply -f db-deployment.yaml'
                        bat 'kubectl apply -f db-service.yaml'
                        bat 'kubectl apply -f web-deployment.yaml'
                        bat 'kubectl apply -f web-service.yaml'
                    }
                }
            }
        }
    }
}
