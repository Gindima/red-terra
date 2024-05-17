pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS = credentials('docker-hub-creds')
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig'
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
                        def webTagExists = bat(script: "docker images ${DOCKER_USERNAME}/red-line-web", returnStatus: true) == 0
                        def dbTagExists = bat(script: "docker images ${DOCKER_USERNAME}/red-line-db", returnStatus: true) == 0
                        
                        if (!webTagExists) {
                            bat "docker tag red-line-web ${DOCKER_USERNAME}/red-line-web"
                        }
                        if (!dbTagExists) {
                            bat "docker tag red-line-db ${DOCKER_USERNAME}/red-line-db"
                        }
                        
                        bat "docker push %DOCKER_USERNAME%/red-line-web"
                        bat "docker push %DOCKER_USERNAME%/red-line-db"
                    }
                }
            }
        }
        stage('Déploiement sur Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_FILE')]) {
                    script {
                        // Définit la variable d'environnement KUBECONFIG pour pointer vers le fichier kubeconfig temporaire
                            bat "kubectl apply -f kubernetes/db-deployment.yaml"
                            bat "kubectl apply -f kubernetes/db-service.yaml"
                            bat "kubectl apply -f kubernetes/web-deployment.yaml"
                            bat "kubectl apply -f kubernetes/web-service.yaml"
                    }
                }
            }
        }
    }
}
