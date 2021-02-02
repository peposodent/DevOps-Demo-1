            pipeline {
                        environment {
                                    EMAIL_TO = 'devops81@gmail.com'
                                    registry = "devops81/devops"
                                    registryCredential = 'dockerhub'
                                    dockerImage = ''
                                    }
                agent {
                    label "master"
                            customWorkspace '/home/workspace'
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
                            checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/devops81/DevOps-Demo.git']]])
                            
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
                                  'Archiving the reports': 
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
                           
                            echo 'Deploy Steps'
                            
                        }
                    }
                    
         

    
           
                    
                  
                }
                       
   post {
               always {
                          emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n The build changes:\n ${env.changes}\n More info at: ${env.BUILD_URL}",
                recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
                           
               }
        failure {
            emailext body: 'Check console output at ${env.BUILD_URL} to view the results. \n\n ${env.CHANGES} \n\n -------------------------------------------------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
                    to: "${EMAIL_TO}", 
                    subject: "Build failed in Jenkins:  ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
        }
        unstable {
            emailext body: 'Check console output at ${env.BUILD_URL} to view the results. \n\n ${env.CHANGES} \n\n -------------------------------------------------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
                    to: "${EMAIL_TO}", 
                    subject: "Unstable build in Jenkins: ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
        }
        changed {
            emailext body: 'Check console output at ${env.BUILD_URL} to view the results.', 
                    to: "${EMAIL_TO}", 
                    subject: "Jenkins build is back to normal: ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
        }
    
}
                
                
            }
                   
                    
                        
            
