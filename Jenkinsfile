pipeline {
  agent { label 'builder' }

  environment {
    BRANCH = env.BRANCH_NAME.replace('/', '-')
    SERVICE              = "rails-api-project"
    IMAGE_TAG            = "${env.BRANCH}-${env.BUILD_NUMBER}"
    CI_IMAGE_TAG         = "CI-${env.BRANCH}-${env.BUILD_NUMBER}"
    REGISTRY             = "317905390022.dkr.ecr.eu-central-1.amazonaws.com"
    REGISTRY_REGION      = "eu-central-1"
  }

  stages {

    stage('build') {
      steps {
        script {
          startTime = new Date().getTime()
        }
        node('docker') {
          checkout scm
          sh 'docker build -t $SERVICE/$IMAGE_TAG .'
        }
      }
      post {
        always {
          deleteDir()
        }
      }
    }
  }
}
