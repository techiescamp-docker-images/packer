@Library('jenkins-shared-library@develop') _

pipeline {
    agent {
        docker {
            image '814200988517.dkr.ecr.us-west-2.amazonaws.com/base-image:1.0.0'
            args '-v /var/run/docker.sock:/var/run/docker.sock --privileged -u root'
            reuseNode true
            }
    }

    stages {
        stage('Lint Dockerfile') {
            steps {
                hadoLint()
            }
        }
    }
}