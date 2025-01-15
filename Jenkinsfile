pipeline {
    agent {
        docker {
            image 'jenkins-playwright:latest' // Используй созданный образ
            args '--shm-size=2g' // Увеличиваем объем памяти для браузеров
        }
    }
    environment {
        PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = 1 // Пропуск повторной загрузки браузеров
    }
    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Run Playwright Tests') {
            steps {
                sh 'npx playwright test'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: '**/test-results/**/*.*', allowEmptyArchive: true
            publishHTML(target: [
                allowMissing: true,
                keepAll: true,
                reportDir: 'playwright-report',
                reportFiles: 'index.html',
                reportName: 'Playwright Report'
            ])
        }
    }
}
