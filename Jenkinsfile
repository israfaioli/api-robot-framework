pipeline {
        agent any

        stages {
            stage('Build') {
                steps {
                    echo 'Build starting...'
                    git url: "https://github.com/alefecvo/api-robot-framework.git"
                    sh(script:"pip3 install robotframework")
                    sh(script:"pip3 install robotframework-requests")
                }
            }
            stage('Test') {
                steps {
                    echo 'Test starting...'
                    sh(script:"robot -d ./logs api/tests/booksTest.robot")
                }
            }
        }
    }