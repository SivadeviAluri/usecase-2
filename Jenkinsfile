pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('worker-slave')  
    }

    stages {
        stage('Install Terraform') {
            steps {
                sh '''
                sudo apt-get update -y
                sudo apt-get install -y unzip curl gnupg software-properties-common
                TERRAFORM_VERSION=1.5.7
                curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
                rm -rf terraform
                unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip
                sudo mv terraform /usr/local/bin/
                terraform version
                '''
            }
        }
        stage('Terraform init') {
            steps {
                sh '''
                rm -rf usecase-2
                git clone https://github.com/SivadeviAluri/usecase-2.git
                ls -R .
                cd usecase-2/calculator/
                terraform init
                terraform apply --auto-approve
                '''
            }
        }
    }
}
