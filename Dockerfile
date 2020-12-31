FROM tomcat:8

# Take the war and copy to webapps of tomcat

COPY target/devops.war  /usr/local/tomcat/webapps/
