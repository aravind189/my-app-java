pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'aravind189/my-java-app:latest'
        DOCKER_CREDENTIALS_ID = 'docker-hub'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/aravind189/my-app-java.git', branch: 'main'
            }
        }

        stage('Build Java Application') {
            steps {
                def mvnHome = tool name: MAVEN_TOOL, type: 'maven'
                sh "${mvnHome}/bin/mvn clean package"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push ${DOCKER_IMAGE}
                    '''
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed."
        }
    }
}
