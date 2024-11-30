pipeline {
    agent any
    environment {
        EC2_IP = '172.31.45.157'
        SSH_KEY = 'hnrs.pem'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'git@github.com:KabhiKabhiAdt/SpringBootStudentManagement.git'
            }
        }
        stage('Build Application') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Deploy to EC2') {
            steps {
                sh """
                scp -i ${SSH_KEY} target/application.jar ubuntu@${EC2_IP}:/home/ubuntu/
                ssh -i ${SSH_KEY} ubuntu@${EC2_IP} "nohup java -jar /home/ubuntu/application.jar > /home/ubuntu/application.log 2>&1 &"
                """
            }
        }
    }
}
