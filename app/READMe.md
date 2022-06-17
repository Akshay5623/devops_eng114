# Let's build a Continuous Integration and Continuous Delivery/Deployment (CICD) Pipeline
## Jenkins CI job Testing
### Webhooks with Git-hub
#### Automated Testing using Jenkins
#### Automated Deployment on AWS EC2 for 2Tier architecture - Nodejs app and Mongodb  
- CI test wtih Eng114 - second push
- testing CI  from localhost
- git flow test 1
- Jenkins Workflow
- feature added from localhost  new attempt
![](images/jenkins.png)

  ##### Contiounus Integration Continuous Delivery/Deployment 
![](images/CICD.png)

###### Let's break it down 
  ![](images/cicd_jenkins.png)

### For deployment job in Jenkins
- In the execute shell of CD job
- new webhook testing
```
# we need to by pass the key asking stage with below command:
ssh -A -o "StrictHostKeyChecking=no" ubuntu@ec2-ip << EOF	
# copy the the code
# run your provision.sh to install node with required dependencies for app instance - same goes for db instance (ensure to double check if node and db are actively running)

# create an env to connect to db
# navigate to app folder
# kill any existing pm2 process just in case
# launch the app
nohup node app.js > /dev/null 2>&1 & - use this command to run node app in the background

# To debug ssh into your ec2 and run the above commands
    

EOF
```
## Jenkins CI Lab - Solution

##### Steps

##### Source Code Management

1. Set Branches to Build to develop
2. Under additional behaviours click add and "Merge before build"
3. name of repo "origin"
4. branch to merge "main"

### Post-Build Actions

#### Git Publisher

1. Add Post Build Action
2. Git Publisher
3. Push Only if Build Succeeds
4. Merge Results
5. change made on dev brance

--- 
Tigger deployment job if the merge was successfull
- Testing webhook in bootcamp test3
- -testing
