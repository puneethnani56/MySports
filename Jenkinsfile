pipeline {
    agent any

    tools {
        maven 'Mymaven'        // Jenkins → Global Tool Configuration
        jdk 'Java17'           // Jenkins → Global Tool Configuration
    }

    environment {
        SONARQUBE = 'MySonarQube'                          // Jenkins → Configure SonarQube servers
        SONAR_TOKEN = credentials('sonar-token')           // Add your SonarQube token in Jenkins credentials (Secret Text)
        ARTIFACTORY_CREDS = credentials('artifactory-creds') // Jenkins → Credentials (username/password)
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
                    sh 'mvn sonar:sonar -Dsonar.login=$SONAR_TOKEN'
                }
            }
        }

        stage('Deploy Artifact to JFrog Artifactory') {
            steps {
                withCredentials([
                    usernamePassword(credentialsId: 'artifactory-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')
                ]) {
                    // Write custom settings.xml file dynamically
                    writeFile file: 'custom-settings.xml', text: """
                        <settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
                                  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                                  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                                                      https://maven.apache.org/xsd/settings-1.0.0.xsd">
                          <servers>
                            <server>
                              <id>jfrog-repo</id>
                              <username>${USERNAME}</username>
                              <password>${PASSWORD}</password>
                            </server>
                          </servers>
                        </settings>
                    """

                    // Use the custom settings file for deployment
                    sh '''
                        mvn deploy -DskipTests \
                            -s custom-settings.xml \
                            -DaltDeploymentRepository=jfrog-repo::default::http://localhost:8082/artifactory/libs-release-local
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build and Deployment successful!"
        }
        failure {
            echo "❌ Build or Deployment failed. Check logs."
        }
    }
}
