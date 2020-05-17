# Installation and Configuration
This scripts conenct to remote servers to report on their CPU,DISK and RAM usage and output in an html format.
Its works on centos, redhat and cloudinux systems

Requirements:
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



