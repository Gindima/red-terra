pipeline {
    agent any
    
    environment {
        SERVICE_CREDS = credentials('docker-hub-creds')
        DOCKER_PASSWORD = "${credentials('docker-hub-creds').password}"
    }
    
    stages {
        stage('Récupérer le code depuis GitHub') {
            steps {
                // Récupérer le code depuis GitHub
                git 'https://github.com/Gindima/alibaba.git'
            }
        }
        
        stage('Construction des images Docker') {
            steps {
                // Utiliser Docker Compose pour construire les images Docker
                sh 'docker-compose up'
            }
        }
        
        stage('Build and Push Docker Images') {
            steps {                
                // Tag des images
                sh "docker tag ligne-rouge-web $SERVICE_CREDS_USR/ligne-rouge-web"
                sh "docker tag ligne-rouge-db $SERVICE_CREDS_USR/ligne-rouge-db"
                
                // Connexion à Docker Hub et push des images
                sh "docker login -u $SERVICE_CREDS_USR -p $SERVICE_CREDS_PSW"
                sh "docker push $SERVICE_CREDS_USR/ligne-rouge-web"
                sh "docker push $SERVICE_CREDS_USR/ligne-rouge-db"
            }
        }
    }
}