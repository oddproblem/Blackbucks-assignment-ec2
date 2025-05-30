# Blackbucks-assignment-ec2
This is an project made by me as final submission for BlackBucks cloud computing course
# AWS Auto Scaling Web App with Load Balancer
🚀 Live Demo (copy & paste): 
`http://autoscale-lb-1976940408.eu-north-1.elb.amazonaws.com/`


## Project Overview

This project demonstrates how to deploy a scalable and highly available web application on AWS. It uses an Auto Scaling Group (ASG) of EC2 instances running NGINX behind an Application Load Balancer (ALB). The ASG automatically adjusts the number of instances based on CPU load, ensuring efficient use of resources and high availability.

---

## Step-by-Step Guide

### Step 1: Create a Launch Template with User Data

1. **Log in to the AWS Management Console.**  
2. Navigate to the **EC2 Dashboard**.  
3. In the left sidebar, click **Launch Templates**.  
4. Click **Create launch template**.  
5. Enter a name, e.g., `autoscale-nginx-template`.  
6. Under **Application and OS Images (Amazon Machine Image)**, select an Amazon Linux 2 AMI.  
7. Choose an instance type (e.g., `t2.micro` or `t3.micro`).  
8. Scroll down to **Advanced Details** → **User data**.  
9. Paste the following User Data script (this runs once when the instance boots):  
   ```bash
   #!/bin/bash
   yum update -y
   amazon-linux-extras install nginx1 -y
   echo "<h1>Hello from $(hostname) 🚀</h1>" > /usr/share/nginx/html/index.html
   systemctl enable nginx
   systemctl start nginx
Configure security groups to allow HTTP traffic (port 80) and SSH (port 22) if needed.
Click Create launch template.

Step 2: Create an Auto Scaling Group (ASG)
In the AWS Console, go to EC2 Dashboard → Auto Scaling Groups.
Click Create Auto Scaling group.
Give your ASG a name like nginx-autoscale-asg.
Select the launch template you created earlier (autoscale-nginx-template).
Choose your VPC and at least one subnet.
Set the group size:
Minimum capacity: 1
Desired capacity: 1
Maximum capacity: 3
Attach an Application Load Balancer (create one if you don’t have it yet):
Configure listeners on port 80 (HTTP).
Set health check protocol to HTTP and path /.
Configure scaling policies:
Use Target Tracking Scaling Policy.
Set target value to 50% average CPU utilization.
Review and create the Auto Scaling group.

Step 3: Test Your Setup
Wait a few minutes for the ASG to launch an instance.
Navigate to the DNS URL of your Application Load Balancer (something like http://your-alb-dns-name).
You should see a simple webpage displaying:
Hello from ip-XX-XX-XX-XX
where ip-XX-XX-XX-XX is the hostname of the EC2 instance serving your request.

To test scaling, SSH into the instance(s) and run CPU stress:

sudo yum install -y stress-ng
stress-ng --cpu 2 --timeout 300
Watch the ASG launch additional instances when CPU usage rises. Refresh the Load Balancer URL to see different hostnames indicating multiple instances are serving traffic.

Step 4: Manage and Monitor
Use the AWS Console to monitor your Auto Scaling group activity, instances, and load balancer health checks.
Check CloudWatch metrics for CPU utilization and scaling events.
To update the app or scripts, modify the launch template with a new version and update your ASG to use it.

User Data Script Explanation
yum update -y: Updates all installed packages to the latest versions.
amazon-linux-extras install nginx1 -y: Installs the NGINX web server.
echo "<h1>Hello from $(hostname) 🚀</h1>" > /usr/share/nginx/html/index.html: Creates a simple HTML page displaying the instance’s hostname.
systemctl enable nginx: Ensures NGINX starts automatically on instance boot.
systemctl start nginx: Starts the NGINX service immediately.
