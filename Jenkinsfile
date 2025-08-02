pipeline {
  agent any
  tools {
    maven 'Maven3'
    jdk 'OpenJDK11'
  }
  environment {
    SONAR_TOKEN = credentials('sonar-token')
  }
  stages {
    stage('Clone') {
      steps {
        git 'https://github.com/<your-username>/my-sports.git'
      }
    }
    stage('Build & Test') {
      steps {
        sh 'mvn clean test'
      }
    }
    stage('Code Quality - SonarQube') {
      steps {
        withSonarQubeEnv('MySonarQube') {
          sh '''
            mvn sonar:sonar \
              -Dsonar.projectKey=my-sports \
              -Dsonar.host.url=http://localhost:9000 \
              -Dsonar.login=$SONAR_TOKEN
          '''
        }
      }
    }
    stage('Package') {
      steps {
        sh 'mvn package'
      }
    }
  }
}
