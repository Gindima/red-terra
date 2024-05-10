pipeline {
    agent any
    
    environment {
        DOCKER_USERNAME = "${credentials('docker-hub-creds').username}"
        DOCKER_PASSWORD = "${credentials('docker-hub-creds').password}"
    }
    
    stages {
        stage('Récupérer le code depuis GitHub') {
            steps {
                // Récupérer le code depuis GitHub
                git 'https://github.com/votre-utilisateur/votre-projet.git'
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
                sh "docker tag ligne-rouge-web ${DOCKER_USERNAME}/ligne-rouge-web"
                sh "docker tag ligne-rouge-db ${DOCKER_USERNAME}/ligne-rouge-db"
                
                // Connexion à Docker Hub et push des images
                sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                sh "docker push ${DOCKER_USERNAME}/ligne-rouge-web"
                sh "docker push ${DOCKER_USERNAME}/ligne-rouge-db"
            }
        }
    }
}