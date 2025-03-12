FROM tomcat:9-jre9
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY ./demo_war.war /usr/local/tomcat/webapps/ROOT.war