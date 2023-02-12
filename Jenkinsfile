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
        incrementMetrics(metric: "jenkinsBuild", service: "${SERVICE}", stage: "builds", branch: "${BRANCH}")
        node('builder') {
          checkout scm
          sh '''
            echo "IMAGE_TAG: $IMAGE_TAG"
            echo "CI_IMAGE_TAG: $CI_IMAGE_TAG"
            aws ecr get-login --no-include-email --region $REGISTRY_REGION | sh
            docker pull $REGISTRY/$SERVICE:latest
            docker build \
              --target deploy \
              --cache-from $REGISTRY/$SERVICE:latest \
              -t $REGISTRY/$SERVICE:$IMAGE_TAG \
              --build-arg IMAGE_TAG .
            docker build \
              --target ci \
              --cache-from $REGISTRY/$SERVICE:$IMAGE_TAG \
              -t $REGISTRY/$SERVICE:$CI_IMAGE_TAG \
              --build-arg IMAGE_TAG .
            docker push $REGISTRY/$SERVICE:$CI_IMAGE_TAG
            docker push $REGISTRY/$SERVICE:$IMAGE_TAG
          '''
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
