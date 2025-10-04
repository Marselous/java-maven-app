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
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                    // gv.checkoutCode()
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
                        sh "docker build -t justfreak/demo-app:${IMAGE_NAME} ."
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
        stage("blank") {
            steps {
                script {
                    echo "blank..."
                    // gv.deployApp()
                }
            }
        }               
        stage("commit version update") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins"'

                        sh 'git status'
                        sh 'git branch'
                        sh 'git config --list'

                        sh 'git remote set-url origin https://${USER}:${PASS}@github.com/Marselous/java-maven-app.git'
                        sh 'git add .'
                        sh 'git commit -m "ci: version bump"'
                        // sh 'git commit -m "Jenkins build: Bumped version to ${IMAGE_NAME}"'
                        sh 'git push origin HEAD:jenkins-jobs'
                    // echo "Deploying the app..."
                    // gv.deployApp()
                }
            }
        }               
    }
} 
