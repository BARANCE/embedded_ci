pipeline {
    agent any

    stages {
        stage('Build and test'){
            parallel {
                stage('Build') {
                    steps {
                        build job: 'arduino_build'
                    }
                }
                stage('Test') {
                    steps {
                        build job: 'arduino_test'
                    }
                }
            }
        }
        stage('Install') {
            steps {
                build job: 'arduino_install'
            }
        }
    }
}