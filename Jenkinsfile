// def gv

pipeline {   
    agent any

    // parameters {
    //     choice(name: 'VERSION', choices: ['1.1.0', '1.2.0', '1.3.0'], description: '')
    //     booleanParam(name: 'executeTests', defaultValue: true, description: 'Execute tests')
    // }

    // tools {
    //     maven 'maven-3.9.11'
    // }

    stages {

        // stage("init") {
        //     steps {
        //         script {
        //             gv = load "script.groovy"
        //         }
        //     }
        // }



        // stage("build jar") {
        //     steps {
        //         script {
        //             echo "Building the app..."
        //             // sh 'mvn package'
        //             gv.buildJar()

        //         }
        //     }
        // }

        stage("test") {
            steps {
                script {
                    echo "Testing the app..."
                    echo "Executing pipeline for branch $BRANCH_NAME"
                    // gv.testApp()
                }
            }
        }

        stage("build") {
            when {
                expression {
                    BRANCH_NAME == 'master'
                }
            }
            steps {
                script {
                    gv.buildApp()
                }
            }
        }

        // stage("build image") {
        //     steps {
        //         script {
        //             echo "Building the docker image..."
        //             // withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        //             //     sh 'docker build -t justfreak/demo-app:jma-2.0 .'
        //             //     sh 'echo $PASS | docker login -u $USER --password-stdin'
        //             //     sh 'docker push justfreak/demo-app:jma-2.0'
        //             // }
        //             gv.buildImage()
        //         }
        //     }
        // }

        stage("deploy") {
            when {
                expression {
                    BRANCH_NAME == 'master'
                }
            }
            steps {
                script {
                    echo "Deploying the app..."
                    // gv.deployApp()
                }
            }
        }               
    }
} 
