#!/user/bin/env groovy

library identifier: 'jenkins-shared-library@master', retriever: modernSCM(
    [$class: 'GitSCMSource',
    remote: 'https://github.com/Marselous/jenkins-shared-library.git',
    credentialsId: 'github-credentials'
    ]
)

pipeline {   
    agent any
    tools {
        maven 'maven-3.9.11'
    }

    // environment {
    //     IMAGE_NAME = 'justfreak/demo-app:1.1.4-19'
    // }

    stages {
        stage ("increment version") {
            steps {
                script {
                    echo "incrementing app version..."
                    sh 'mvn build-helper:parse-version versions:set \
                    -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                    versions:commit'
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                }
            }
        }

        stage("build app") {
            steps {
                script {
                    echo "building the app..."

                    buildJar()
                }
            }
        }

        stage("build image") {
            steps {
                script {
                    echo "building the image..."

                    buildImage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                }
            }
        }       
        
        stage("deploy") {
            steps {
                script {
                    echo "deploying docker image to remote-server..."

                    def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME}" // set parameter to be passed to server-cmds.sh
                    def destinationServer = "zerg@192.168.56.105"

                    sshagent(['ssh-key-jenkins']) {
                        sh "scp server-cmds.sh ${destinationServer}:/home/zerg"
                        sh "scp docker-compose.yaml ${destinationServer}:/home/zerg/apps/containers"
                        sh "ssh -o StrictHostKeyChecking=no ${destinationServer} ${shellCmd}"
                    }
                }
            }
        }

        stage("commit version update") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github-credentials-pat', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins"'

                        sh 'git status'
                        sh 'git branch'
                        sh 'git config --list'

                        sh 'git remote set-url origin https://${USER}:${PASS}@github.com/Marselous/java-maven-app.git'
                        sh 'git add .'
                        sh 'git commit -m "ci: ${IMAGE_NAME} version bump"'
                        sh 'git push origin HEAD:jenkins-jobs'
                    }
                }
            }
        }                   
    }
} 
