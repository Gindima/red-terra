pipeline {
    agent any
    dependency 'org.apache.tools.ant:ant:1.10.8'
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Gindima/alibaba.git', branch: 'main'
            }
        }

        stage('Vérifier le répertoire et les fichiers') {
            steps {
                script {
                    println "Répertoire de travail : ${env.WORKSPACE}"

                    // Lister les fichiers en utilisant la bibliothèque Ant
                    sh """
                    ant -lib ${env.JENKINS_HOME}/lib/ant-contrib.jar list fileset(dir: ${env.WORKSPACE})
                    """
                }
            }
        }
    }
}
