#!/user/bin/env groovy

library identifier: 'jenkins-shared-library@master', retriever: modernSCM(
    [$class: 'GitSCMSource',
    remote: 'https://github.com/Marselous/jenkins-shared-library.git',
    credentialsId: 'github-credentials'])

def gv

pipeline {   
    agent any
    tools {
        maven 'maven-3.9.11'
    }

    stages {

        stage("init") {
            steps {
                script {
                    gv = load "script.groovy"
                }
            }
        }

        stage("build jar") {
            steps {
                script {
                    echo "Building the app..."
                    buildJar()
                }
            }
        }

        stage("build image") {
            steps {
                script {
                    echo "Building the docker image..."
                    buildImage 'justfreak/demo-app:jma-3.0'
                }
            }
        }

        stage("deploy") {
            steps {
                script {
                    echo "Deploying the app..."
                    gv.deployApp()
                }
            }
        }               
    }
} 
