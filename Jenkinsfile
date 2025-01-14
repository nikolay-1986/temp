pipeline {
   agent { 
		docker { 
			image 'mcr.microsoft.com/playwright:v1.49.1-noble' 
			args '-u root'
		} 
	}
   environment {
        //CI = 'true' // Помечает запуск как CI
		DOCKER_HOST = 'unix:///var/run/docker.sock' // Указываем путь к Docker сокету
    }
	stages {
        stage('Prepare Environment') {
            steps {
                script {
                    sh '''
                    # Убедимся, что Docker установлен
                    docker -v || apt-get update && apt-get install -y docker.io

                    # Запустим Docker, если он не активен
                    if ! systemctl is-active --quiet docker; then
                        systemctl start docker
                    fi
                    '''
                }
            }
        }
        stage('Run Playwright Docker Container') {
            steps {
                script {
                    sh '''
                    # Запуск Playwright контейнера
                    docker run --rm \
                        -v $PWD:/workdir \
                        -w /workdir \
                        --ipc=host \
                        mcr.microsoft.com/playwright:latest \
                        bash -c "npx playwright install && npx playwright test"
                    '''
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline завершен.'
        }
    }
	
	
 //  stages {   
//	  stage('Install dependencies') {
 //           steps {
  //              script {
//					sh '''
//					# Check that Node.js is installed
 //                   node -v || apt-get update && apt-get install -y nodejs npm
 //                   npm install --global npm@latest
//					# Install Playwright
//					npm install -D playwright
//                    npx playwright install
//                    # Set dependencies
//                    sh 'npm ci'
//					'''
//                }
//            }
//        }
//      stage('Run e2e tests') {
//            steps {
//                script {
//					sh '''
//                    # Запустить тесты
//                    sh 'npx playwright test'
//					'''
//                }
//            }
//        }
//   }
//   post {
//        always {
//	    node (docker) {
//            	   archiveArtifacts artifacts: '**/test-results/**', allowEmptyArchive: true
//        	   junit '**/test-results/*.xml'
//		}
//        }
 //       failure {
 //           echo 'Tests failed!'
 //       }
 //   }
}
