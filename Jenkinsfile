pipeline {   
    agent any
    stages {
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
