pipeline {
    agent any

    tools {
        maven 'Mymaven'        // Must match Jenkins Maven tool name
        jdk 'Java17'           // Must match Jenkins JDK tool name
    }

    environment {
        SONARQUBE = 'MySonarQube'                           // SonarQube server name (configured in Jenkins)
        SONAR_TOKEN = credentials('sonar-token')            // Sonar token stored as Secret Text
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

                    sh '''
                        mvn deploy -DskipTests \
                            -s custom-settings.xml \
                            -DaltDeploymentRepository=jfrog-repo::default::http://localhost:8082/artifactory/libs-release-local
                    '''
                }
            }
        }

        stage('Deploy to Tomcat via Ansible') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'artifactory-creds', usernameVariable: 'ART_USER', passwordVariable: 'ART_PASS')]) {
                    sh '''
                        echo "⚙️ Running Ansible deployment playbook..."
                        ansible-playbook -i ansible/inventory ansible/deploy.yml -e "art_user=$ART_USER art_pass=$ART_PASS"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build, Upload, and Deployment successful!"
        }
        failure {
            echo "❌ Build, Upload, or Deployment failed. Please check the logs."
        }
    }
}
