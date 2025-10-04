#!/user/bin/env groovy
@Library('jenkins-shared-library') _
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
                    buildImage()
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
