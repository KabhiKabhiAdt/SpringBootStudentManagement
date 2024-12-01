pipeline {
    agent any
    environment {
        EC2_IP = '98.83.161.100'        
        SSH_KEY = '/usr/local/hnrs.pem'            
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/KabhiKabhiAdt/SpringBootStudentManagement.git',
                    credentialsId: 'GithubAT' 
            }
        }
        stage('Build Application') {
            steps {
                sh '/usr/local/maven/bin/mvn clean package'
            }
        }
        stage('Deploy to EC2') {
            steps {
                sh """
                scp -o StrictHostKeyChecking=no -i ${SSH_KEY} target/SpringBootRegistrationLogin-1.0.jar ubuntu@${EC2_IP}:/home/ubuntu/
                ssh -o StrictHostKeyChecking=no -i ${SSH_KEY} ubuntu@${EC2_IP} "nohup java -jar /home/ubuntu/SpringBootRegistrationLogin-1.0.jar > /home/ubuntu/SpringBootRegistrationLogin-1.0.log 2>&1 &"
                """
            }
        }
    }
}
