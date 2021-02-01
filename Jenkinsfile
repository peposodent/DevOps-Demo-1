            pipeline {
                        environment {
                                    EMAIL_TO = 'devops81@gmail.com'
                                    registry = "wbbdocker1/devops"
                                    registryCredential = 'dockerhub'
                                    dockerImage = ''
                                    }
                agent {
                    label "master"
                }
                         triggers {
                                    pollSCM('* * * * *')
                                  }
                tools {
                    maven 'maven3'
            
                }
                stages {
                    stage ('Initialize') {
                        steps {
                            sh '''
                                echo "PATH = $PATH"
                                echo "M2_HOME = $M2_HOME"
                            '''
                        }
                    }
            
                    stage ('Checkout') {
                        steps {
                            checkout([$class: 'GitSCM', branches: [[name: '*/DPLExample']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/devops81/DevOps-Demo.git']]])
                            
                        }
                    }
                    
                    stage ('Build the project') {
                        steps {
                            
                      
                               sh '''
                                cd "/root/.jenkins/workspace/Declarative Pipeline example/examples/feed-combiner-java8-webapp"
                                mvn clean install
                                '''   }
                    }
                    
                      stage ('Generate JUNIT REPORT') {
                         steps {
                              parallel ( 
                                  'Archeiving the reports': 
                        {
                            junit 'examples/feed-combiner-java8-webapp/target/surefire-reports/*.xml'
                            
                        },
                                  'Sending out the JUNIT report' :
                                  {                  
                                     echo "Test email" /*emailext body: 'Junits reporting getting archived', subject: 'junit update', to: 'wbbjenkins.training@gmail.com'*/
                                 }
                                          
                                       
                                 )
                        } 
                    }
                            stage('Building image') {
                                    steps{
                                                script {
                                                            dockerImage = docker.build registry + ":$BUILD_NUMBER"
                                                       }
                                                    }
                                         }
                             stage("Docker login") {
               steps {
                    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub',
                               usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                         sh "docker login --username $USERNAME --password $PASSWORD"
                    }
               }
          }
                            
                             stage("Docker push") {
                                    steps {
                                    sh "docker push wbbdocker1/devops:$BUILD_NUMBER"
                                          }
          }

                    stage ('Deploy the application') {
                        steps {
                           
                            echo 'I can copy stuffs here'
                            
                        }
                    }
                    
         

    
           
                 /*  stage ('Send slack notification')
                            {
                                        steps 
                                        {
                                                   slackSend baseUrl: 'https://hooks.slack.com/services/', channel: '#krishnademo', color: 'good', message: '"#439FE0", message: "Build Started: ${env.JOB_NAME} ${env.BUILD_NUMBER}"', teamDomain: 'devops81', tokenCredentialId: 'SlackKrishnademo'
                                        }
                            }*/
                    
                  
                }
                        post {
   post {
               always {
                           emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n -------------------------------------------------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
                    to: "${EMAIL_TO}", 
                    subject: 'Current status of BUild : $PROJECT_NAME - #$BUILD_NUMBER'
                           
               }
        failure {
            emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n -------------------------------------------------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
                    to: "${EMAIL_TO}", 
                    subject: 'Build failed in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
        }
        unstable {
            emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n -------------------------------------------------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
                    to: "${EMAIL_TO}", 
                    subject: 'Unstable build in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
        }
        changed {
            emailext body: 'Check console output at $BUILD_URL to view the results.', 
                    to: "${EMAIL_TO}", 
                    subject: 'Jenkins build is back to normal: $PROJECT_NAME - #$BUILD_NUMBER'
        }
    }
}
                
                
            }
                   
                    
                        
            
