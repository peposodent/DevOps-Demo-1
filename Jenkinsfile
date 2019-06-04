            pipeline {
                agent {
                    label "master"
                }
                tools {
                    maven 'Maven3'
            
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
                                cd "/var/lib/jenkins/workspace/Declarative Pipeline example/examples/feed-combiner-java8-webapp"
                                mvn test install
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
                                     emailext body: 'Junits reporting getting archived', subject: 'junit update', to: 'devops81@gmail.com'
                                 }
                                          
                                       
                                 )
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
                            emailext body: '$DEFAULT_CONTENT', subject: '$DEFAULT_SUBJECT', to: 'devops81@gmail.com'
            
                            
                        }
                    }
                            
                   stage ('Send slack notification')
                            {
                                        steps 
                                        {
                                                    slackSend baseUrl: 'https://devops81.slack.com/', tokenCredentialId: 'SLACK-JENKINS-NOTIFY', channel: '#Krishnademo', color: 'good', message: 'Slack build status', teamDomain: 'devops81'
                                        }
                            }
                    
                  
                }
                
                
            }
                   
                    
                        
            
