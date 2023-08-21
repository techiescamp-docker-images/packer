pipeline {
    agent{
        label 'AGENT-01'
    }
    
    environment {
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
                    docker tag packer-image:01 ${ECR_REPO}/${REPO_NAME}:${TAG}
                    docker push ${ECR_REPO}/${REPO_NAME}:${TAG}
                '''
            }
        }
    }
}