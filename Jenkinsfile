pipeline {
    agent any

    environment {
        APP_NAME = "bible-admin"
        IMAGE_NAME = "bible-admin"
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Maven') {
            steps {
                sh '''
                  mvn clean verify -Pprod -DskipTests
                '''
            }
        }

        stage('Build Image') {
            steps {
                sh '''
                  docker build -t ${IMAGE_NAME} .
                '''
            }
        }

        stage('Deploy Production') {
            steps {
                sh '''
                  docker compose down
                  docker compose up -d
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deploy bible-admin berhasil"
        }
        failure {
            echo "❌ Build atau deploy gagal"
        }
    }
}
