# Installation and Configuration
This scripts conenct to remote servers to report on their CPU,DISK and RAM usage and output in an html format.
Its works on centos, redhat and cloudinux systems

#Requirements:
1. A Webserver - ( I used Apache in this example)
2. passwordless ssh login between webserver and remote servers

installation of webserver:
yum install httpd httpd-tools -y

setting up of passwordless ssh login between webserver and remote servers:
On Webserver:
ssh-keygen -t rsa

After the above completes, then you need to copy public key to each server you want to report resources;
For example:
ssh-copy-id root@10.10.0.10

#Configuration
clone the repository to /root on your webserver:
cd /root
https://github.com/eamoany/serverstatsreport.git

#create a folder on webserver DocRoot:
If its Apache and its the default DocRoot,then create folder as below
mkdir -p /var/www/html/serverstatsreport
copy the contents of the html folder to the folder /var/www/html/serverstatsreport

#modifications and customisation
1. You need to edit server-list and enter your IPs
2. You can also edit the stats.sh to modify the html templates.You can add your logo as well

Finally you need to create a cron job for time you want the script to be runing.In my lab, i have set to 11:55pm GMT
55 11 * * * /bin/sh /root/scripts/serverstatsreport.sh 2>&1


