            pipeline {
                        environment {
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
    always {
         script {
                        
                        cest = TimeZone.getTimeZone("CEST")
                        def cest = new Date()
                        println(cest) 
                        def mailRecipients = 'traveldiariesforu@gmail.com'
                        def jobName = currentBuild.fullDisplayName
                        env.Name = Name
                        env.cest = cest
                        emailext body: '''${SCRIPT, template="francois.email.groovy.template"}''',
                        mimeType: 'text/html',
                        subject: "[Jenkins] ${jobName}",
                        to: "${mailRecipients}",
                        replyTo: "${mailRecipients}"
                        
                            }
    }
}
                
                
            }
                   
                    
                        
            
