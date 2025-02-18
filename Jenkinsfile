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

                # Define the target directory with write permissions
                $targetDirectory = "C:\\inetpub\\wwwroot\\PoC"

                # Check if the target directory exists, if not, attempt to create it
                if (!(Test-Path -Path $targetDirectory)) {
                    try {
                        New-Item -ItemType Directory -Path $targetDirectory -Force
                        Write-Host "Created directory: $targetDirectory"
                    } catch {
                        Write-Host "Failed to create directory: $_"
                        exit 1
                    }
                }

                # Copy website files to the target directory
                Write-Host "Copying files to $targetDirectory..."
                Copy-Item -Path build\\* -Destination $targetDirectory -Recurse -Force

                # Optional: Restart IIS if needed, but this requires admin privileges
                # Uncomment the following line if you have the necessary permissions
                # iisreset
                '''
            }
        }
    }
}
