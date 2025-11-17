pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('hello')
    }
    stages {
        stage('checkout') {
            steps {
                echo "*********** cloning the code **********"
                sh 'rm -rf Calculator-demo || true'
                sh 'git clone https://github.com/SivadeviAluri/Calculator-demo.git'    
            }
        }
        
        stage('Artifact build') {
            steps {
                echo "********** building is done ************"
                dir('Calculator-demo/calculator') {
                    sh 'mvn clean package -DskipTests -Dcyclonedx.skip=true -Dcheckstyle.skip=true'
                }
            }
        }
        
        stage('Prepare for Docker Build') {
            steps {
                dir('Calculator-demo/calculator/target') {
                    stash name: 'java-artifact', includes: 'calculator-0.0.1-SNAPSHOT.jar'
                }
                dir('Calculator-demo') {
                    stash name: 'Dockerfile', includes: 'Dockerfile'
                }
            }
        }
        
        stage('Build Docker Image') {
            agent { 
                label 'worker-slave'
            } 
            steps {
                // Unstash artifacts on the slave node
                unstash 'java-artifact'
                unstash 'Dockerfile'
                sh 'docker build -t devi/calculator:v1 .'
            }
        }
        
        stage('Push to Docker Hub') {
            agent { 
                label 'worker-slave'
            } 
            steps {
                sh """
                docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}
                docker push devi819/calculator:v1
                """
            }
        }
    }
}
