pipeline {
    agent{
        label 'AGENT-01'
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
    }
}