
node('master') {

stage ('SCM Checkout') {
	checkout([$class: 'GitSCM', branches: [[name: '*/DPLExample']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/devops81/DevOps-Demo.git']]])

}

stage ('Compile-Packages')

{
def mvnHome = tool name: 'MVN3', type: 'maven'
dir('/var/lib/jenkins/workspace/FOLDER1/Java-Maven-Pipeline/examples/feed-combiner-java8-webapp')
{ 
sh "${mvnHome}/bin/mvn clean install"}
}
stage ('Generate JUNIT REPORT') 
	        {
                junit 'examples/feed-combiner-java8-webapp/target/surefire-reports/*.xml' 
            	}
 stage('SonarQub Analysis') {

def mvnHome = tool name: 'MVN3', type: 'maven'

withSonarQubeEnv('SONARQUBESERVER') {
dir('/var/lib/jenkins/workspace/FOLDER1/Java-Maven-Pipeline/examples/feed-combiner-java8-webapp')
{
sh "${mvnHome}/bin/mvn sonar:sonar"
}
}

}


stage ('Build Notification')

{
emailext body: '${SCRIPT, template="francois.email.groovy.template"}', recipientProviders: [developers()], subject: '$PROJECT_DEFAULT_SUBJECT', to: 'devops@81@gmail.com'
}

stage ('Deploy to QA')
{

sh 'sudo rm -rf /home/user/warfile/devops.war'
sh 'sudo cp  -rf  /var/lib/jenkins/workspace/FOLDER1/Java-Maven-Pipeline/examples/feed-combiner-java8-webapp/target/devops.war /home/user/warfile/'

}




stage ('Deployment Notification')

{
emailext body: '${SCRIPT, template="francois.email.groovy.template"}', recipientProviders: [developers()], subject: '$PROJECT_DEFAULT_SUBJECT', to: 'devops@81@gmail.com'
}

}
