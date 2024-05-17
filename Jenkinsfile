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
                    def webImageExists = bat(script: "docker images -q ligne-rouge-web", returnStatus: true) == 0
                    def dbImageExists = bat(script: "docker images -q ligne-rouge-db", returnStatus: true) == 0
                    
                    if (webImageExists) {
                        bat "docker rmi ligne-rouge-web"
                    }
                    if (dbImageExists) {
                        bat "docker rmi ligne-rouge-db"
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
                    bat "docker tag ligne-rouge-web ${dockerUsername}/ligne-rouge-web"
                    bat "docker tag ligne-rouge-db ${dockerUsername}/ligne-rouge-db"
                    
                    // Connexion à Docker Hub et push des images
                    bat "echo ${dockerPassword} | docker login -u ${dockerUsername} --password-stdin"
                    bat "docker push ${dockerUsername}/ligne-rouge-web"
                    bat "docker push ${dockerUsername}/ligne-rouge-db"
                }
            }
        }
    }
}
