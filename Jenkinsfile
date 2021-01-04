            pipeline {
                        environment {
                                    registry = "devops81/devops"
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
                                cd "/var/jenkins_home/workspace/Declarative Pipeline example/examples/feed-combiner-java8-webapp"
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
                                     echo "Test email" /*emailext body: 'Junits reporting getting archived', subject: 'junit update', to: 'devops81@gmail.com'*/
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
                             stage("Docker push") {
               steps {
                    sh docker push registry + ":$BUILD_NUMBER"
               }
          }

                    stage ('Deploy the application') {
                        steps {
                           
                            echo 'I can copy stuffs here'
                            
                        }
                    }
                    stage ('Send out email Notification') {
                        agent {
                            label "master"
                        }
                        steps {
                            echo "Test notification" /* emailext body: '$DEFAULT_CONTENT', subject: '$DEFAULT_SUBJECT', to: 'devops81@gmail.com'*/
            
                            
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
                
                
            }
                   
                    
                        
            
