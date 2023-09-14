@Library('jenkins-shared-library@main') _

pipeline {
    agent{
        label 'AGENT-01'
    }

    stages {
    
        stage('Build Docker Image') {
            agent {
                docker {
                    image 'techiescamp/base-image:latest'
                    args '-v /var/run/docker.sock:/var/run/docker.sock --privileged '
                    reuseNode true
                }
            }
            environment {
                DOCKER_CONFIG = '/tmp/docker'
            }
            steps {
                script {
                    try {
                        dockerBuild(
                            versionTag: "1.0",
                            imageName: "packer-image"
                        )
                    } catch (Exception buildError) {
                        currentBuild.result = 'FAILURE'
                        error("Failed to build Docker image: ${buildError}")
                    }
                }
            }
        }
        stage('Run Trivy Scan') {
            steps {
                script {
                    try {
                        def imageNameAndTag = "packer-image:1.0"
                        trivyScan(imageNameAndTag)
                    } catch (Exception trivyError) {
                        currentBuild.result = 'FAILURE'
                        error("Trivy scan failed: ${trivyError}")
                    }
                }
            }
        }
        stage('Send Trivy Report') {
            steps {
                script {
                    try {
                        def imageNameAndTag = "packer-image:1.0"
                        def reportPath = "trivy-report.html"
                        def recipient = "aswin@crunchops.com"
                        emailReport(reportPath,imageNameAndTag, recipient)
                    } catch (Exception emailError) {
                        currentBuild.result = 'FAILURE'
                        error("Email Send failed: ${emailError}")
                    }
                }
                }
            }
        stage('Slim Docker Image') {
            when {
                expression { false }
            }
            steps {
                script {
                    try {
                        def imageNameAndTag = "packer-image:1.0"
                        slimImage(imageNameAndTag)
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error("Failed to slim Docker image: ${e.message}")
                    }
                }
            }
        }
    }

    post {
            success {
                script {
                    emailNotification.sendEmailNotification('success', 'aswin@crunchops.com')
                    }
                }
            failure {
                script {
                    emailNotification.sendEmailNotification('failure', 'aswin@crunchops.com')
                    }
                }
        always {
            cleanWs()
        }
    }
}

