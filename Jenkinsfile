pipeline {
    agent{
        label 'AGENT-01'
    }
    stages{
        
        stage('Build'){
            steps{
                docker build -t packer-image .
                }
            }
        }
    }