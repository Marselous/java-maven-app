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

    environment {
        IMAGE_NAME = 'justfreak/demo-app:1.1.4-19'
    }

    stages {
        // stage ("increment version") {
        //     steps {
        //         script {
        //             echo "Incrementing app version..."
        //             sh 'mvn build-helper:parse-version versions:set \
        //             -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
        //             versions:commit'
        //             def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
        //             def version = matcher[0][1]
        //             env.IMAGE_NAME = "$version-$BUILD_NUMBER"
        //             // gv.checkoutCode()
        //         }
        //     }
        // }

        stage("build app") {
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
                    echo "Building the image..."
                    buildImage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                }
            }
        }       

        // stage("commit version update") {
        //     steps {
        //         script {
        //             withCredentials([usernamePassword(credentialsId: 'github-credentials-pat', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        //                 sh 'git config --global user.email "jenkins@example.com"'
        //                 sh 'git config --global user.name "jenkins"'

        //                 sh 'git status'
        //                 sh 'git branch'
        //                 sh 'git config --list'
        //                 sh 'git remote set-url origin https://${USER}:${PASS}@github.com/Marselous/java-maven-app.git'
        //                 sh 'git add .'
        //                 sh 'git commit -m "ci: version bump"'
        //                 // sh 'git commit -m "Jenkins build: Bumped version to ${IMAGE_NAME}"'
        //                 sh 'git push origin HEAD:jenkins-jobs'
        //                 // gv.deployApp()
        //             }
        //         }
        //     }
        // }
        
        stage("deploy") {
            steps {
                script {
                    echo "deploying docker image to remote-server..."
                    def shellCmd = "bash ./server-cmds.sh"
                    // def dockerComposeCmd = "docker-compose -f /home/zerg/apps/containers/docker-compose.yaml up --detach"
                    // def dockerCmd = "docker run -d -p 3080:3080 --name java-app justfreak/demo-app:1.1.4-19"
                    sshagent(['ssh-key-jenkins']) {
                        sh "scp server-cmds.sh zerg@192.168.56.105:/home/zerg"
                        sh "scp docker-compose.yaml zerg@192.168.56.105:/home/zerg/apps/containers"
                        sh "ssh -o StrictHostKeyChecking=no zerg@192.168.56.105 ${shellCmd}"
                        // sh "ssh -o StrictHostKeyChecking=no zerg@192.168.56.105 ${dockerComposeCmd}"
                        // sh "ssh -o StrictHostKeyChecking=no zerg@192.168.56.105 ${dockerCmd}"
                    }
                }
            }
        }                   
    }
} 
