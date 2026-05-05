pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Blendgashi05/mini-prod-devops.git'
            }
        }

        stage('Test') {
            steps {
                sh './scripts/ci/test.sh'
            }
        }

        stage('Build') {
            steps {
                sh './scripts/ci/build.sh'
            }
        }

        stage('Terraform') {
            steps {
                sh './scripts/ci/terraform.sh'
            }
        }

        stage('Ansible') {
            steps {
                sh './scripts/ci/ansible.sh'
            }
        }

        stage('Deploy') {
            steps {
                sh './scripts/ci/deploy.sh'
            }
        }

        stage('Smoke Test') {
            steps {
                sh './scripts/ci/smoke.sh'
            }
        }

        stage('Switch to Green') {
            steps {
                sh './scripts/ci/switch.sh'
            }
        }
    }

    post {
        failure {
            echo "Pipeline failed - rollback skipped"
        }
    }
}
