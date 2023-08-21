pipeline {
    agent{
        label 'AGENT-01'
    }
    
    environment {
        AWS_ACCESS_KEY_ID     = sh(script:'aws secretsmanager get-secret-value --secret-id aws_cred --query SecretString --output text | jq -r .ACCESS_KEY', returnStdout: true).trim()
        AWS_SECRET_ACCESS_KEY = sh(script:'aws secretsmanager get-secret-value --secret-id aws_cred --query SecretString --output text | jq -r .SECRET_KEY', returnStdout: true).trim()
        REGION                = 'us-west-2'
        ECR_REPO              = '814200988517.dkr.ecr.us-west-2.amazonaws.com/docker-images'
        REPO_NAME             = 'docker-images'
        TAG                   = 'packer'
    }

    stages{
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build'){
            steps{
                sh '''
                docker build -t packer-image:01 .
                '''
                }
            }
        stage('Scan Image') {
            steps {
            sh '''
            sudo trivy image packer-image:01
            '''
            }
        }
        stage('Push to ECR'){
            steps {
                sh '''
                    aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ECR_REPO}
                    docker tag packer-image:01 ${ECR_REPO}/${REPO_NAME}:${TAG}
                    docker push ${ECR_REPO}/${REPO_NAME}:${TAG}
                '''
            }
        }
    }
}