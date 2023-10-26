pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Get the branch name from the webhook payload
                  //    def branchName = env.BRANCH_NAME
                    // Clone the repository
			echo "Started"
		//	echo $branchName
                      sh "git clone git@github.com:abhishek-charlee/test.git -b main"
                }
            }
        }
        stage('Start Server') {
            steps {
                // Run your server start script
  //            #  sh './start_server.sh'
		echo "Hello server started"
            }
        }
    }
    post {
        success {
		echo "Post build success"
            // Add any post-build actions or notifications
        }
    }
}

