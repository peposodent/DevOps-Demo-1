FROM tomcat:8

# Take the war and copy to webapps of tomcat
ARG src="/var/jenkins_home/workspace/Declarative Pipeline example/examples/feed-combiner-java8-webapp/target/devops.war"
ARG target="/usr/local/tomcat/webapps/"
COPY ${src} ${target}
