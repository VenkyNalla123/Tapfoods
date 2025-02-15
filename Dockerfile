# Use Tomcat as the base image
FROM tomcat:9.0

# Set working directory inside the container
WORKDIR /usr/local/tomcat/webapps/

# Copy the exported WAR file into Tomcat's webapps directory
COPY TAPFOODS.war TAPFOODS.war

# Expose Tomcat's default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
