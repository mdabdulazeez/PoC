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
                powershell 'Copy-Item -Path * -Destination build -Recurse -Exclude build'
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
        stage('Deploy to IIS') {
            steps {
                powershell '''
                Write-Host "Deploying website to IIS..."
                # Ensure IIS is installed
                $iisFeature = Get-WindowsFeature -Name Web-Server
                if (-not $iisFeature.Installed) {
                    Write-Host "IIS is not installed. Installing now..."
                    Install-WindowsFeature -Name Web-Server -IncludeManagementTools
                }
                
                # Copy website files to IIS root directory
                Write-Host "Copying files to IIS root..."
                Copy-Item -Path build\\* -Destination C:\\inetpub\\wwwroot -Recurse -Force
                
                # Restart IIS to apply changes
                Write-Host "Restarting IIS..."
                iisreset
                '''
            }
        }
    }
}
