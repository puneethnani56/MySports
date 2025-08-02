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
        git 'https://github.com/puneethnani56/MySports.git'
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

    stage('Upload Artifact to Artifactory') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'artifactory-creds', usernameVariable: 'ART_USER', passwordVariable: 'ART_PASS')]) {
        sh '''
          curl -u $ART_USER:$ART_PASS \
          -T target/my-sports.war \
          "http://localhost:8082/artifactory/libs-release-local/com/mysports/my-sports/1.0.0/my-sports-1.0.0.war"
          '''
        }  
      }
    }
  }
}
