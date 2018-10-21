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
                dir("/var/lib/jenkins/workspace/Miscelleneous/10212018/examples/feed-combiner-java8-webapp") {
                sh 'mvn install package'
                }
                
            }
        }
          stage ('Generate JUNIT REPORT') {
            steps {
                junit 'examples/feed-combiner-java8-webapp/target/surefire-reports/*.xml'
                
            }
        }
        stage ('Deploy the application') {
            steps {
                /bin/cp  -rf  /var/lib/jenkins/workspace/Miscelleneous/10212018/examples/feed-combiner-java8-webapp/target/devops.war /home/ec2-user/tomcat/apache-tomcat-9.0.12/webapps/
                
            }
        }
        }
       
                      
}
