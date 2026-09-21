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
         sh "sudo docker build -f docker/Dockerfile -t cloud-devops-learn-docker:${BUILD_NUMBER} ."
}
}

    stage('Run container') {
       steps{
          sh "sudo docker rm -f cloud-devops-learn-docker-test || true"
          sh "sudo docker run -d --name cloud-devops-learn-docker-test -p 5000:5000 cloud-devops-learn-docker:${BUILD_NUMBER}"
}
}

   stage('Smoke test') {
      steps{
         sh "curl -f http://localhost:5000/health"
}
}
}

   post{
     always{
       sh "sudo docker logs cloud-devops-learn-docker-test || true"
       sh "sudo docker rm -f cloud-devops-learn-docker-test || true"
}
}
}
 
          
