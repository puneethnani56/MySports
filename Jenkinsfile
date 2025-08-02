pipeline {
    agent any

    tools {
        maven 'Mymaven'        // Set this name in Jenkins → Global Tool Configuration
        jdk 'Java17'          // Set this name as Java 17 path in Jenkins
    }

    environment {
        SONARQUBE = 'MySonarQube'              // Jenkins → Configure SonarQube servers
        ARTIFACTORY_CREDS = credentials('artifactory-creds') // Jenkins → Credentials (username/password or API Key)
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/puneethnani56/MySports.git'
            }
        }

        stage('Build & Unit Test') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Code Coverage Report (JaCoCo)') {
            steps {
                sh 'mvn test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${env.SONARQUBE}") {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Deploy Artifact to JFrog Artifactory') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'artifactory-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        mvn deploy -DskipTests \
                            -DaltDeploymentRepository=jfrog-repo::default::http://localhost:8082/artifactory/libs-release-local \
                            -Dusername=$USERNAME \
                            -Dpassword=$PASSWORD
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Build and Deployment successful!"
        }
        failure {
            echo "Build or Deployment failed. Check logs."
        }
    }
}
