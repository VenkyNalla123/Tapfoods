# Use official Tomcat 9 image with JDK 21
FROM tomcat:9.0-jdk-21

# Set environment variable for Railway's dynamic port assignment
ENV PORT=8080

# Copy the WAR file from the target directory to Tomcat's webapps folder
COPY target/tapfood.war /usr/local/tomcat/webapps/ROOT.war

# Expose the correct port (Railway will map it automatically)
EXPOSE ${8080}

# Start Tomcat
CMD ["sh", "-c", "catalina.sh run"]
