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
                withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        // Tag des images
                        bat "docker tag red-line-web ${DOCKER_USERNAME}/red-line-web"
                        bat "docker tag red-line-db ${DOCKER_USERNAME}/red-line-db"
                        
                        // Connexion à Docker Hub et push des images
                        bat "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                        bat "docker push ${DOCKER_USERNAME}/red-line-web"
                        bat "docker push ${DOCKER_USERNAME}/red-line-db"
                    }
                }
            }
        }
    }
}
