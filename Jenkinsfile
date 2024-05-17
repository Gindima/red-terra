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
                script {
                    def dockerUsername = env.DOCKER_CREDENTIALS_USR
                    def dockerPassword = env.DOCKER_CREDENTIALS_PSW

                    // Tag des images
                    bat "docker tag red-line-web ${dockerUsername}/red-line-web"
                    bat "docker tag red-line-db ${dockerUsername}/red-line-db"
                    
                    // Connexion à Docker Hub et push des images
                    bat "echo ${dockerPassword} | docker login -u ${dockerUsername} --password-stdin"
                    bat "docker push ${dockerUsername}/red-line-web"
                    bat "docker push ${dockerUsername}/red-line-db"
                }
            }
        }
    }
}
