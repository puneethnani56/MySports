DevOps Silver Badge Capstone Project 

Project Title:
--------------
CI/CD Automation of My-Sports Java Web Application

Team:
-----
Name: Puneeth Kumar Bhojanapu

Repository:
-----------
GitHub: https://github.com/puneethnani56/MySports

Application:
------------
A sample Java Maven Web Application called "My-Sports" with basic login and registration functionality implemented using JSP and Servlets.

====================================================================
PHASE 1 – Source Code and Version Control (Git & GitHub)
====================================================================
✔ Created and initialized a Git repository for the project on GitHub.
✔ Used Git for source control with proper commit history for each module added (JSPs, Servlets, Jenkinsfile).
✔ Integrated GitHub with Jenkins using Webhooks to automatically trigger pipeline jobs on code push.

====================================================================
PHASE 2 – Build Automation with Maven & Unit Testing
====================================================================
✔ Used Maven as the build tool to compile the application, run unit tests, generate `.war` file.
✔ `pom.xml` configured with dependencies, JaCoCo plugin, and deploy plugin.
✔ Created unit test stubs and integrated `mvn test` and `mvn clean install` in the CI pipeline.

====================================================================
PHASE 3 – CI Pipeline with Jenkins
====================================================================
✔ Installed Jenkins on a local Ubuntu system.
✔ Configured GitHub SCM polling and webhook triggers.
✔ Created a scripted Jenkinsfile and pushed it to GitHub for pipeline-as-code approach.
✔ Jenkinsfile stages:
   - Clone from GitHub
   - Build & Unit Test (Maven)
   - SonarQube Analysis
   - Package `.war` artifact
   - Upload `.war` to JFrog Artifactory
   - Trigger Ansible Playbook for Tomcat deployment

====================================================================
PHASE 4 – Artifact Management with JFrog Artifactory
====================================================================
✔ Installed JFrog Artifactory OSS locally.
✔ Created a `libs-release-local` repository.
✔ Configured Jenkins credentials for Artifactory.
✔ Automatically uploaded the `.war` file to Artifactory using Maven deploy and `curl`.

Repository Path:
http://localhost:8082/artifactory/libs-release-local/com/mysports/my-sports/1.0/my-sports-1.0.war

====================================================================
PHASE 5 – Configuration Management & Deployment with Ansible
====================================================================
✔ Created an `Ansible` playbook to:
   - Download the `.war` file from Artifactory
   - Stop Apache Tomcat server
   - Copy `.war` file to `webapps` folder
   - Restart Tomcat server

✔ Added variables for Artifactory credentials to make playbook reusable.
✔ Deployment tested and verified successfully on localhost Tomcat.

====================================================================
PHASE 6 – Application Deployment on Apache Tomcat
====================================================================
✔ Installed Apache Tomcat 9 and configured it to run on port 8080.
✔ Successfully deployed the My-Sports application via Jenkins-triggered Ansible.
✔ Verified deployment by accessing:
   http://localhost:8080/my-sports/

====================================================================
PHASE 7 – Application Functionalities (Bonus)
====================================================================
✔ Implemented basic JSP pages: index.jsp, login.jsp, register.jsp.
✔ Developed and mapped two servlets:
   - `LoginServlet.java`: Validates login and redirects.
   - `RegisterServlet.java`: Dummy registration and redirection.
✔ Updated `web.xml` with proper servlet mappings.

====================================================================
CI/CD Pipeline Summary:
-----------------------
Trigger: GitHub push → Jenkins → Maven build → Sonar → JFrog upload → Ansible deployment → Tomcat

Tools Used:
-----------
✔ Git & GitHub – Version Control & Collaboration  
✔ Maven – Build Automation  
✔ Jenkins – CI/CD Orchestration  
✔ SonarQube – Code Quality & Static Analysis  
✔ JaCoCo – Code Coverage Reports  
✔ JFrog Artifactory – Artifact Repository  
✔ Ansible – Deployment Automation  
✔ Apache Tomcat – Application Server  
✔ Bash/Unix – Shell Scripting and Local Setup

====================================================================
Project Status:
---------------
✅ CI/CD Pipeline: Fully Functional  
✅ All Tools Installed & Integrated Locally  
✅ WAR File Deployed via Pipeline  
✅ Web App Functionality Verified
