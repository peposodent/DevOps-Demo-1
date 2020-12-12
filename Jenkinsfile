pipeline {
agent {
    label "LinuxAgent-New"
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
            checkout([$class: 'GitSCM', branches: [[name: '*/AgentExample']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], 
                      userRemoteConfigs: [[url: 'https://github.com/devops81/DevOps-Demo.git']]])
            
        }
    }
    
    stage ('Build the project') {
        steps {
            
      
               sh '''
                cd "/home/cloud_user/workspace/AgentExample/examples/feed-combiner-java8-webapp"
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
            label "LinuxAgent-New"
        }
        steps {
            emailext body: '$DEFAULT_CONTENT', subject: '$DEFAULT_SUBJECT', to: 'devops81@gmail.com'

            
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

      junit '/home/cloud_user/workspace/AgentExample/examples/feed-combiner-java8-webapp/target/surefire-reports/*.xml'
  } 
}
}
