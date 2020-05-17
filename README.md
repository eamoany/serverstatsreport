# Installation and Configuration
This scripts conenct to remote servers to report on their CPU,DISK and RAM usage and output in an html format.
Its works on centos, redhat and cloudinux systems

<b>Requirements:</b><br />
1. A Webserver - ( I used Apache in this example)<br />
2. passwordless ssh login between webserver and remote servers<br />

<b>installation of webserver:</b><br />
yum install httpd httpd-tools -y<br />

<b>setting up of passwordless ssh login between webserver and remote servers:</b><br />
On Webserver:<br />
ssh-keygen -t rsa<br />

After the above completes, then you need to copy public key to each server you want to report resources;<br />
For example:<br />
ssh-copy-id root@10.10.0.10<br />

<b>Configuration</b><br />
clone the repository to /root on your webserver:<br />
cd /root<br />
https://github.com/eamoany/serverstatsreport.git<br />

<b>create a folder on webserver DocRoot:</b><br />
If its Apache and its the default DocRoot,then create folder as below<br />
mkdir -p /var/www/html/serverstatsreport<br />
copy the contents of the html folder to the folder /var/www/html/serverstatsreport<br />

<b>modifications and customisation:</b><br />
1. You need to edit server-list and enter your IPs<br />
2. You can also edit the stats.sh to modify the html templates.You can add your logo as well<br />

Finally you need to create a cron job for time you want the script to be runing.In my lab, i have set to 11:55pm GMT<br />
55 11 * * * /bin/sh /root/scripts/serverstatsreport.sh 2>&1<br />


