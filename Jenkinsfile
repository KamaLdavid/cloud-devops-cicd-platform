pipeline {
   agent any
   
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
         sh "docker build -f docker/Dockerfile -t cloud-devops-learn-docker:${BUILD_NUMBER} ."
}
}

    stage('Run container') {
       steps{
          sh "docker rm -f cloud-devops-learn-docker-test || true"
          sh "docker run -d --name cloud-devops-learn-docker-test -p 5000:5000 cloud-devops-learn-docker:${BUILD_NUMBER}"
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
 
          
