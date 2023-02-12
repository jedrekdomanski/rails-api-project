pipeline {
  agent { label 'docker' }

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
          sh 'docker build --cache-from $SERVICE:latest -t $SERVICE/$IMAGE_TAG .'
        }
      }
      post {
        always {
          deleteDir()
        }
      }
    }

    stage('test') {
      steps {
        script {
          node('docker') {
            try {
              sh 'docker-compose -f docker-compose.yml up -d'
              sh 'docker-compose -f docker-compose.yml run web bundle exec rspec RAILS_ENV=test DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
            } catch (exc) {
              echo "EXCEPTION: ${exc}"
              throw exc
            } finally {
              sh 'docker-compose -f docker-compose.yml down'
              deleteDir()
            }
          }
        }
      }
    }
  }
}
