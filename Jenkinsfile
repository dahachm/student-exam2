pipeline {
    environment {
        imagename = "dahachm/js_example"
        registryCredential = 'dockerhub_pass'
    }
    
    agent { label 'agent-1' }
    stages {
        stage('Checkout code') {
            steps {
                checkout scm
            }
        }
        
        stage('Run Python tests') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -e '.[test]'
                    coverage run -m pytest
                    coverage report
                '''
            }
        }
        
        stage('Building image') {
            steps {
                script {
                    dockerImage = docker.build imagename
                }
            }
        }

        stage('Deploy Image') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push("$BUILD_NUMBER")
                    }
                }
            }
        }

        stage('Remove Unused docker image') {
            steps {
                sh "docker rmi $imagename:$BUILD_NUMBER"
            }
        }
    }
}

