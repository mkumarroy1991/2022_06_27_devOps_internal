pipeline {
    agent any 
    environment {
        registryCredential = 'dockerhub_cred'
        imageName = 'manishroy1710/external'
        dockerImage = ''
        }
    stages {
        stage('Run the tests') {
             agent {
                docker { 
                    image 'node:18-alpine'
                    args '-e HOME=/tmp -e NPM_CONFIG_PREFIX=/tmp/.npm'
                    reuseNode true
                }
            }
            steps {
                echo 'Retrieve source from github' 
                git branch: 'master',
                    url: 'https://github.com/mkumarroy1991/2022_06_27_devOps_internal.git'
                echo 'showing files from repo?' 
                sh 'ls -a'
                echo 'install dependencies' 
                sh 'npm install'
                echo 'Run tests'
                sh 'npm test'
                echo 'Testing completed'
            }
        }
        stage('Building image') {
            steps{
                script {
                    echo 'building image' 
                    dockerImage = docker.build("${env.imageName}:${env.BUILD_ID}")
                    echo 'image built'
                }
            }
            }
        stage('Push Image') {
            steps{
                script {
                    echo 'pushing the image to docker hub' 
                    docker.withRegistry('',registryCredential){
                        dockerImage.push("${env.BUILD_ID}")
                    }
                }
            }
        }     
         stage('deploy to k8s') {
             agent {
                docker { 
                    image 'google/cloud-sdk:latest'
                    args '-e HOME=/tmp'
                    reuseNode true
                        }
                    }
            steps {
                echo 'Get cluster credentials'
                sh 'gcloud container clusters get-credentials demo-node-app-cluster --zone us-central1-c --project roidtc-june22-u113'
                sh "kubectl set image deployment/demo-node-internal-deployment demo-node-internal=${env.imageName}:${env.BUILD_ID} -n demo"

             }
        }     
        stage('Remove local docker image') {
            steps{
                echo "pending"

                sh "docker rmi ${env.imageName}:${env.BUILD_ID}"
            }
        }
    }
}