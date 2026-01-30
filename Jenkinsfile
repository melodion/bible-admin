pipeline {
    agent any

    environment {
        APP_NAME = "bible-admin"
        IMAGE_NAME = "bibleadmin"
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {

        stage('Checkout') {
        agent any
            steps {
                checkout scm
            }
        }

        stage('Unit Test') {
            steps {
                sh '''
                  mvn clean test -Pprod
                '''
            }
        }

        stage('Build Maven') {
            steps {
                sh '''
                  mvn clean package -Pprod -DskipTests
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

        stage('Deploy Image') {
            environment {
                MYSQL_DATABASE = credentials('mysql-database')
                MYSQL_USER = credentials('mysql-user')
                MYSQL_PASSWORD = credentials('mysql-password')
                MYSQL_ROOT_PASSWORD = credentials('mysql-root-password')
            }
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
