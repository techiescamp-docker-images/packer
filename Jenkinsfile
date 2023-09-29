@Library('jenkins-shared-library@develop') _

pipeline {
    agent {
        docker { image '814200988517.dkr.ecr.us-west-2.amazonaws.com/base-image:1.0.0' }
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    try {
                        dockerBuild(
                            imageName: 'test'
                        )
                    } catch (Exception buildError) {
                        currentBuild.result = 'FAILURE'
                        error("Failed to build Docker image: ${buildError}")
                    }
                }
            }
        }
        stage('Push Image To ECR') {
            steps {
                script {
                    try {
                        ecrRegistry(
                            imageName: 'test',
                            repoName: 'base-image',
                        )
                    } catch (Exception pushError) {
                        currentBuild.result = 'FAILURE'
                        error("Failed to push image to ECR: ${pushError}")
                    }
                }
            }
        }
    }
}