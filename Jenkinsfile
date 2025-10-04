def gv

pipeline {   
    agent any
    tools {
        maven 'maven-3.9.11'
    }

    stages {

        // stage("init") {
        //     steps {
        //         script {
        //             gv = load "script.groovy"
        //         }
        //     }
        // }
        
        stage ("increment version") {
            steps {
                script {
                    echo "Incrementing app version..."
                    sh 'mvn build-helper:parse-version versions:set \
                    -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                    versions:commit'
                    def matcher = readFile('pom.xml') =~ '<version>(.+)<\/version>'
                    def version = matcher[0][1]
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                    // gv.checkoutCode()
                    }
                }
            }
        }
        stage("build app") {
            steps {
                script {
                    echo "Building the app..."
                    sh 'mvn clean package'
                    // sh 'mvn package'
                    // gv.buildJar()

                }
            }
        }

        stage("build image") {
            steps {
                script {
                    echo "Building the docker image..."
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "docker build -t justfreak/demo-app:${"IMAGE_NAME} ."
                        sh 'echo $PASS | docker login -u $USER --password-stdin'
                        sh "docker push justfreak/demo-app:${IMAGE_NAME}"
                        // sh 'docker push justfreak/demo-app:jma-4.0'
                        // gv.buildImage()
                    }
                }
            }
        }

        stage("deploy") {
            steps {
                script {
                    echo "Deploying the app..."
                    // gv.deployApp()
                }
            }
        }               
    }
} 
