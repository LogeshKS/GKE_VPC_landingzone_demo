properties([
    parameters([
        string(
            defaultValue: 'dev',
            name: 'Environment'
        ),
        choice(
            choices: ['plan', 'apply', 'destroy'], 
            name: 'Terraform_Action'
        )])
])
pipeline {
    agent any
    environment {
        GOOGLE_CREDENTIALS = credentials('terraform_sa')  // Jenkins credential ID
    }
    stages {
        stage('Preparing') {
            steps {
                sh 'echo Preparing'
            }
        }
        stage('Git Pulling') {
            steps {
                git branch: 'feature1', url: 'https://github.com/LogeshKS/GKE_VPC_landingzone_demo.git'
            }
        }
        stage('Init') {
            steps {
                    sh 'terraform -chdir=environments/dev/ init'
                }
            
        }
        stage('Validate') {
            steps {
                
                sh 'terraform -chdir=environments/dev/ validate'
                
            }
        }
        stage('Action') {
            steps {
                
                    script {    
                        if (params.Terraform_Action == 'plan') {
                            sh "terraform -chdir=environments/dev/ plan -var-file=${params.Environment}.tfvars"
                        }   else if (params.Terraform_Action == 'apply') {
                            sh "terraform -chdir=environments/dev/ apply -var-file=${params.Environment}.tfvars -auto-approve"
                        }   else if (params.Terraform_Action == 'destroy') {
                            sh "terraform -chdir=environments/dev/ destroy -var-file=${params.Environment}.tfvars -auto-approve"
                        } else {
                            error "Invalid value for Terraform_Action: ${params.Terraform_Action}"
                        }
                    }
                
            }
        }
    }
}