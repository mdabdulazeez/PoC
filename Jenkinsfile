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
                
                # Check if IIS is installed using DISM (works on Windows 10/11 and Server)
                $iisInstalled = (dism /online /get-features | Select-String "IIS-WebServer" -Context 0,1) -match "Enabled"
                if (-not $iisInstalled) {
                    Write-Host "IIS is not installed. Installing now..."
                    dism /online /enable-feature /featurename:IIS-WebServer /all
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
