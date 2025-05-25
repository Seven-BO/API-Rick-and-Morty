pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "api-ricky-morty-frontend"
    }

    stages {
        stage('Checkout Source') {
            steps {
                script {
                    checkout scm
                    echo "Repository checked out successfully."
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}"

                    sh "docker build -t ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER} ."
                    sh "docker build -t ${DOCKER_IMAGE_NAME}:latest ." // Also tag with 'latest' for easy reference

                    echo "Docker image built successfully."
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    echo "Deploying Docker container..."
                    sh "docker stop ricky-morty-frontend || true"
                    sh "docker rm ricky-morty-frontend || true"

                    sh "docker run -d --name ricky-morty-frontend -p 80:80 ${DOCKER_IMAGE_NAME}:latest"
                    echo "Docker container deployed successfully on host port 80."

                }
            }
        }
    }

    post {
        always {
            cleanWs() 
        }
        success {
            echo "Pipeline finished successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}