FROM tomcat:8
# Take the war and copy to webapps of tomcat
ARG src="examples/feed-combiner-java8-webapp/target/devops.war"
ARG target="/usr/local/tomcat/webapps/"
COPY ${src} ${target}
