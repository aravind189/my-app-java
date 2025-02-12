pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'priya290/my-java'
        DOCKER_CREDENTIALS_ID = 'docker-hub'
    }
    stages {
        stage('Login') {
            steps {
                withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: '']) {
                    sh 'echo "Docker login successful"'
                }
            }
        }
    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/Priyachowdary290/my-app-java.git', branch: 'main'
            }
        }

        stage('Build Java Application') {
            steps {
                sh "mvn clean package"
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
