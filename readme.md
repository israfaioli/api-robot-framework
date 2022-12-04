FakeAPI Test Project with Robot Framework
This project is used to automation test using FakeAPI with Robot Framework.

Dependencies
Install the items
Visual Code + extension (Robot Framework Language Server + Robot Framework Language + Material Icon)
Python 3 or above
Jenkins 2.303.3 LTS - Generic Java package .war
Run Tests in computer:
Get clone this project to your computer and execute the commands bellow:
Open project with Visual Code.

Run test with compiler or execute commands on Visual Code terminal.

pip3 install robotframework-requests
robot -d ./logs api/tests/booksTest.robot
Access on project '.logs/report.html' and open Chrome browser to see results.

Run Tests in Jenkins CI:
To run tests in Jenkins CI (job) - Get clone this project to your computer and execute the commands bellow:
Download Jenkins.

Run commands to access folder.

cd Download
Run commands to start 'server' Jenkins.

java -jar jenkins.war
or
java -jar jenkins.war —httpPort=9191
or
127.0.0.1:9191
Open browser and navigate to access Jenkins - http://localhost:8080

Add plugin 'robot framework' on Jenkins.

In 'Dashboard'. Click in 'Manager Jenkins'. Click in 'Manager Plugins'. Search 'robot framework'. Click in 'Install without program'.

Create job 'robot framework' on Jenkins.

In 'Dashboard'. Click in 'New Job'. Choose name 'RobotTestJob'. Click in 'Freestyle project' and 'OK'.

Run job 'robot framework' on Jenkins.

Open job created. Click 'Use workspace customize'. Set project folder ex. '/Users/YOUR_USER/api-robot-framework'.

In 'Build'. Click 'execute shell'. Set the commands

cd /Users/YOUR_USER/api-robot-framework
robot -d ./logs api/tests/booksTest.robot
In 'Post Build'. Click 'Publish Robot Framework test results'. Set the commands

/Users/YOUR_USER/api-robot-framework/logs
Click 'Apply' and 'Save'.

Click in 'Build Now'.

Click in 'Robot Results'.

To run tests in Jenkins CI (pipeline) - Execute the commands bellow:
Download Jenkins.

Run commands to access folder.

cd Download
Run commands to start 'server' Jenkins.

java -jar jenkins.war
or
java -jar jenkins.war —httpPort=9191
or
127.0.0.1:9191
Open browser and navigate to access Jenkins - http://localhost:8080

Add plugin 'pipeline' on Jenkins.

In 'Dashboard'. Click in 'Manager Jenkins'. Click in 'Manager Plugins'. Search 'Pipeline'. Click in 'Install without program'.

Create pipeline on Jenkins.

In 'Dashboard'. Click in 'New Job'. Choose name 'PipelineRobot'. Click in 'Pipeline' and 'OK'.

Run job 'robot framework' on Jenkins.

Open pipeline created.

In 'configure'. Click 'advanced project options'.

In 'pipeline'. Choose 'pipeline script' and paste code bellow:

    pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Build starting...'
                git url: "https://github.com/israfaioli/api-robot-framework.git"
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
Click 'Apply' and 'Save'.

Click in 'Build Now'.