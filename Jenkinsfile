pipeline {
   agent any

   environment {
       IMAGE_NAME= "cloud-devops-learn-docker"
       IMAGE_TAG="build-${BUILD_NUMBER}"
}   
   stages {
     stage('validate') {
        steps{
          sh '''
             docker --version 
             python3 --version
          '''
}
}

     stage('Docker build'){
       steps{
         sh "docker build -f docker/Dockerfile -t ${IMAGE_NAME}:${IMAGE_TAG} ."
}
}

    stage('Run container') {
       steps{
          sh "docker rm -f cloud-devops-learn-docker-test || true"
          sh "docker run -d --name cloud-devops-learn-docker-test -p 5000:5000 ${IMAGE_NAME}:${IMAGE_TAG}"
}
}
    stage("Container Health") {
          steps{
             sh '''
                 for i in $(seq 1 12); do
                     status=$(docker inspect --format='{{.State.Health.Status}}' cloud-devops-learn-docker-test)
                            echo "Container health: $status"
                      if [ "$status" = "healthy" ]; then
                          echo "Container is health"
                          exit 0
                       fi

                      if [ "$status" = "unhealthy" ]; then
                            echo "Container is unhealth"
                            exit 1
                       fi 

                       sleep 5
                  done
                  echo "Health check timed out"
                  exit 1
              '''
}
} 

   stage('Smoke test') {
      steps{
         sh '''
             response=$( curl -fsS http://localhost:5000/health)
             test "$response" = "OK"
         '''

}
}
}

   post{
     always{
       sh "docker logs cloud-devops-learn-docker-test || true"
       sh "docker rm -f cloud-devops-learn-docker-test || true"
}
}
}
 
          
