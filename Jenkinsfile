pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mdabdulazeez/PoC.git'
            }
        }
        stage('Build') {
            steps {
                sh 'echo "Building HTML/CSS project"'
                sh 'mkdir -p build'
                sh 'cp -r * build/'
                sh 'echo "Build complete!"'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
    }
}
