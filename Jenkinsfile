pipeline {
    agent{
        label 'AGENT-01'
    }
    
    environment {
        REGION     = 'us-west-2'
        ACCOUNT_ID = '814200988517'
        REPO_NAME  = 'docker-images'
        TAG        = 'packer'
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
                    docker pull ${ACCOUNT_ID}.dkr.ecr.us-west-2.amazonaws.com/${REPO_NAME}:${TAG}
                    docker tag packer-image:01 ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO_NAME}:${TAG}
                    docker push ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO_NAME}:${TAG}
                '''
            }
        }
    }
}