	pipeline {
   agent { 
		docker { 
			image 'mcr.microsoft.com/playwright:v1.49.1-noble' 
		} 
	}
   environment {
        CI = 'true' // Помечает запуск как CI
    }
   stages {
	  stage('Install dependencies') {
            steps {
                script {
                    // Установить зависимости
                    sh 'npm ci'
                }
            }
        }
      stage('Run e2e tests') {
            steps {
                script {
                    // Запустить тесты
                    sh 'npx playwright test'
                }
            }
        }
   }
   post {
        always {
	    node ('any') {
            	   archiveArtifacts artifacts: '**/test-results/**', allowEmptyArchive: true
        	   junit '**/test-results/*.xml'
		}
        }
        failure {
            echo 'Tests failed!'
        }
    }
}
