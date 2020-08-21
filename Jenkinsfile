node {
    def registry1 = 'erhandemirbas/capstone-blue'
    def registry2 = 'erhandemirbas/capstone-green'
    
    stage('Checking out git repo') {
      echo 'Checkout...'
      checkout scm
    }

  stage('Checking environment') {
    echo 'Checking environment...'
    sh 'git --version'
    echo "Branch: ${env.BRANCH_NAME}"
    sh 'docker -v'
  }

  stage("Linting") {
    echo 'Linting'
    sh 'tidy -q -e blue/index.html'
    sh 'tidy -q -e green/index.html'
  }

  stage('Building image blue') {
    echo 'building blue image'
    withCredentials([usernamePassword(credentialsId: 'erhan-docker', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerUsername')]) {
     	sh "docker login -u ${env.dockerUsername} -p ${env.dockerHubPassword}"
     	sh "docker build -t ${registry1} blue/."
     	sh "docker tag ${registry1}"
     	sh "docker push ${registry1}"
    }
  }

  stage('Building image green') {
    echo 'building green image'
    withCredentials([usernamePassword(credentialsId: 'erhan-docker', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerUsername')]) {
     	sh "sudo docker login -u ${env.dockerUsername} -p ${env.dockerHubPassword}"
     	sh "sudo docker build -t ${registry2} green/."
     	sh "sudo docker tag ${registry2}"
     	sh "sudo docker push ${registry2}"
    }
  }
  
  stage('Deploying to AWS EKS') {
    echo 'Deploying to AWS EKS'
    dir ('./') {
      withAWS(credentials: 'user-capstone', region: 'us-west-2') {
          sh "aws eks --region us-west-2 update-kubeconfig --name cluster-capstone"
          sh "kubectl apply -f blue/blue-controller.json"
          sh "kubectl apply -f green/green-controller.json"
          sh "kubectl apply -f ./blue-green-service.json"
          sh "kubectl get nodes"
          sh "kubectl get pods"
      }
    }
  }
}