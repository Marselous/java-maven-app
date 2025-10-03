def gv

pipeline {   
    agent any
    parameters {
        choice(name: 'VERSION', choices: ['1.1.0', '1.2.0', '1.3.0'], description: '')
        booleanParam(name: 'executeTests', defaultValue: true, description: 'Execute tests')
    }
    // tools {
    //     maven 'Maven'
    // }
    stages {
        stage("init") {
            steps {
                script {
                    gv = load "script.groovy"
                }
            }
        }

        stage("build") {
            steps {
                script {
                    gv.buildApp()
                }
            }
        }

        // stage("build jar") {
        //     steps {
        //         script {
        //             gv.buildJar()

        //         }
        //     }
        // }

        stage("test") {
            when {
                expression {
                    params.executeTests
                }
            }
            steps {
                script {
                    gv.testApp()

                }
            }
        }

        // stage("build image") {
        //     steps {
        //         script {
        //             gv.buildImage()
        //         }
        //     }
        // }

        stage("deploy") {
            input {
                message "Please confirm enviorment deploy to"
                ok "Deploy"
                parameters {
                    choice(name: 'ENV1', choices: ['dev', 'staging', 'prod'], description: '')
                    choice(name: 'ENV2', choices: ['dev', 'staging', 'prod'], description: '')
                }
            }
            steps {
                script {
                    gv.deployApp()
                    echo "Deploying to environment ${ENV1}"
                    echo "Deploying to environment ${ENV2}"
                }
            }
        }               
    }
} 
