# cloud-devops-capstone
includes files for capstone project on udacity cloud devops nanodegree

Project files as follows:

AWS - includes eksctl command, cloudformation yaml files
blue - image blue for blue-green deployment
green - image green for blue-green deployment
screenshots - images from project building
Jenkinsfile - pipeline for the project
blue-green-service.json - service file

How to build project:

1 - SSH into Jenkins instance and run eksctl command

2 - After Cloudformation creates resources, create your Jenkins pipeline

3 - Jenkins pipeline will create Docker images and upload to your Docker Hub

4 - Jenkins will pull images from Hub and deploy them into pods

5 - You can load webpage from Loadbalancer link on port 8000
