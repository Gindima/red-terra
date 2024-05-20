pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS = credentials('docker-hub-creds')
        TERRAFORM_DIR = 'terraform'
        PHP_APP_IMAGE = "${DOCKER_CREDENTIALS_USR}/terra-php_app:latest"
        MYSQL_IMAGE = "${DOCKER_CREDENTIALS_USR}/terra-mysql:latest"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Check Docker Images') {
            steps {
                script {
                    def phpAppImageExists = bat(script: "docker pull ${PHP_APP_IMAGE} || true", returnStatus: true) == 0
                    def mysqlImageExists = bat(script: "docker pull ${MYSQL_IMAGE} || true", returnStatus: true) == 0
                    
                    if (!phpAppImageExists) {
                        buildDockerImage('App.Dockerfile', 'terra-php_app')
                    }
                    if (!mysqlImageExists) {
                        buildDockerImage('Db.Dockerfile', 'terra-mysql')
                    }
                }
            }
        }
        
        stage('Build and Push Docker Images') {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub-creds') {
                        if (!bat(script: "docker images -q ${PHP_APP_IMAGE}", returnStatus: true) == 0) {
                            bat "docker tag terra-php_app:latest ${PHP_APP_IMAGE}"
                            bat "docker push ${PHP_APP_IMAGE}"
                        }
                        if (!bat(script: "docker images -q ${MYSQL_IMAGE}", returnStatus: true) == 0) {
                            bat "docker tag terra-mysql:latest ${MYSQL_IMAGE}"
                            bat "docker push ${MYSQL_IMAGE}"
                        }
                    }
                }
            }
        }
        
        stage('Terraform Init and Apply') {
            steps {
                dir(TERRAFORM_DIR) {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        script {
                            bat 'terraform init'
                            bat 'terraform apply -auto-approve'
                        }
                    }
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}

def buildDockerImage(dockerfile, imageName) {
    bat """
        docker build -t ${imageName}:latest -f ${dockerfile} .
        echo ${DOCKER_CREDENTIALS_PSW} | docker login -u ${DOCKER_CREDENTIALS_USR} --password-stdin
    """
}
