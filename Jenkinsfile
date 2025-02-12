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
                powershell 'Write-Host "Building HTML/CSS project"'
                powershell 'New-Item -ItemType Directory -Path build -Force'
                powershell 'Copy-Item -Path * -Destination build -Recurse'
                powershell 'Write-Host "Build complete!"'
            }
        }
        stage('Terraform Init') {
            steps {
                powershell 'terraform init'
            }
        }
        stage('Terraform Apply') {
            steps {
                powershell 'terraform apply --auto-approve'
            }
        }
    }
}
