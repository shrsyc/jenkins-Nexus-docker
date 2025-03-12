pipeline{
    agent any
    tools{
        maven 'maven'
    }
    stages{
        stage('build project'){
            steps{
                sh 'mvn clean package'
            }
        }

        stage('store artifact in nexus'){
            steps{
                sh 'mvn -s settings.xml clean deploy'
            }
            post{
                success{
                    echo 'Artifact stored in Nexus'
                }
                failure{
                    echo 'Failed to store artifact in Nexus'
                }
            }
        }

        stage("push docker immage to dockerhub") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                                sh """
                                docker rmi -f $DOCKER_USER/demo_war || true

                                docker build -t $DOCKER_USER/demo_war .

                                echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                                docker push $DOCKER_USER/demo_war

                                docker logout
                                """
                    }
                            
                }
            }
        }


    }
}