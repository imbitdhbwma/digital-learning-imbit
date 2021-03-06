# Server Initialization: Server Setup Guide

This guide is optimized for setting up the production server to install and configure brillianIDEAS.com

## System Update
First do a system update within the following command
```
sudo apt-get update && apt-get upgrade && apt-get autoremove
Yes
```
Check the warnings during update/ upgrade/ autoremove -
Click [here](https://askubuntu.com/questions/457237/mdadm-warning-system-unbootable-from-update-initramfs-mkconfs-suggested-fix) to see a solution for the following warnings
```
cryptsetup: WARNING: failed to detect canonical device of /dev/md1
cryptsetup: WARNING: could not determine root device from /etc/fstab
W: Possible missing firmware /lib/firmware/ast_dp501_fw.bin for module ast
W: mdadm: the array /dev/md1 with UUID 3bae49aa:8a231f11:1f51fb89:78ee93fe
```


## Install Webmin
In this step Webmin is installed. To see further information click [here](https://wilddiary.com/install-webmin-on-aws-ec2-server/)

```
sudo nano /etc/apt/sources.list
```

To download and install Webmin do the following commands consecutively:
```
deb http://download.webmin.com/download/repository sarge contrib
wget http://www.webmin.com/jcameron-key.asc
sudo apt-key add jcameron-key.asc
sudo apt-get update
sudo apt-get install webmin
```
Install dependencies
```
sudo apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
```
Fix install errors
```
sudo apt-get --fix-broken install
```
Create Webmin user
```
sudo useradd -g sudo webmin
sudo passwd webmin
```
Put in a webmin password
You can access webmin via the browser: https://<publicDNS>:10000/ 
	
## Install LAMP
In this step LAMP is installed. It is a package of (Linux) Apache, MySQL, PHP, Perl, Python. To see further information click [here](https://wiki.ubuntuusers.de/LAMP/)

Installing Lamp
```
sudo apt-get install apache2 libapache2-mod-php7.0 php7.0 php7.0-mysql mysql-server
```
## Install MySQL and Give User Permissions
To install MySql
```
sudo apt-get install mysql-server
mysql -u root
sudo nano /etc/mysql/my.cnf
```
  ** MySQL-server: you need to set a password during LAMP installation
	If you need to reset the root password for the mySQL database click [here](https://coderwall.com/p/j9btlg/reset-the-mysql-5-7-root-password-in-ubuntu-16-04-lts)

--BEGINNING of reset MySQL password--	

To Stop MySQL
```
sudo service mysql stop
```
Make a MySQL service directory.
```
sudo mkdir /var/run/mysqld
```
Give MySQL user permission to write to the service directory.
```
sudo chown mysql: /var/run/mysqld
```
Start MySQL manually, without permission checks or networking.
```
sudo mysqld_safe --skip-grant-tables --skip-networking &
```
Log in without a password.
```
mysql -uroot mysql
```
Update the password for the root user

```
UPDATE mysql.user SET authentication_string=PASSWORD('YOURPASSWORD'), plugin='mysql_native_password' WHERE User='root' AND Host='%';
EXIT;
```
```
mysql -u root -p 
```

Turn off MySQL.
```
sudo mysqladmin -S /var/run/mysqld/mysqld.sock shutdown
```

Start the MySQL service normally.
```
sudo service mysql start
mysql -u root -p 
```
--END of reset MySQL password--


Download and Upload the following files from GitHub /resources/database-files/* to Home (~). With the source command, the commands in the .sql files will be executed. These create the database, tables and contents:

```
mysql -u root -p
source ~/CreateDBbrillianCRM.sql;
source ~/CreateDBbrillianICM.sql;
exit
```


## APACHE 
* default document folder is /var/www/html
* default config folder is /etc/apache2

Create the following .conf files in sites-available:
brillianCRM.conf, brillianICM.conf, brillianIDEAS.conf, mediawiki.conf
with sudo nano fileName.conf and paste the content from GitHub OR download from /resources/Apache-conf-files/* and copy to the folder


cd/etc/apache2/sites-available
```
sudo nano brillianCRM.conf
```
paste content from GitHub
```
sudo nano brillianICM.conf
```
paste content from GitHub
```
sudo nano brillianIDEAS.conf
```
paste content from GitHub
```
sudo nano mediawiki.conf
```
paste content from GitHub

Activate the config by using the following command (it will copy it to sites-enabled)

```
sudo a2ensite <FILE>.conf
sudo a2enmod proxy_http
sudo service apache2 restart
```
Create Ubuntu User
```
sudo groupadd www
```
```
sudo adduser www-user --ingroup www
```
Enter a password: xxxx
```
sudo chgrp -R www /var/www/html
sudo chmod g+w /var/www/html
cd/var/www/html
mkdir brillianIDEAS
cd brillanIDEAS 
```
Copy GitHub status to server (with e.g. winscp or any other FDP client) 
When adding new content change permissions again
```
sudo chmod g+w -R /var/www/html
sudo chgrp -R www /var/www/html
```


## Install Tomcat
In this step Tomcat is installed. It is a container for Java Applications such as brillianICM and brillianCRM. To see further information click [here](https://medium.com/@shaaslam/how-to-install-oracle-java-9-in-ubuntu-16-04-671e598f0116)

### Install JDK9 for Tomcat
Open a terminal and add PPA using following command. You need sudo access to this
```
sudo add-apt-repository ppa:webupd8team/java
```
Update package repository using following command
```
sudo apt-get update
```
Download and Install the installer script
```
sudo apt install oracle-java9-installer
ok
yes
```
Set Oracle JDK9 as default, to set oracle jdk9 as default, install the “oracle-java9-set-default” package. This will automatically set the JAVA env variable
```
sudo apt install oracle-java9-set-default
```

This will complete your installation, you can check you java version by running following command
```
javac -version
```
Change JAVA_HOME variable
```
nano.bashrc
```
Set environment variable with correct path
```
#JAVA_HOME env
export JAVA_HOME=/usr/lib/jvm/java-9-oracle
#JRE_HOME env
export JRE_HOME=/usr/lib/jvm/java-9-oracle
#CATALINA_HOME env
export CATALINA_HOME=/opt/tomcat
#CATALINA_BASE env
export CATALINA_BASE=/opt/tomcat
```
```
sudo update-java-alternatives -l
```
To test the environment variables, use echo:
```
echo $JAVA_HOME
```
### Install Tomcat Server
```
sudo groupadd tomcat
```
Download to save in target gz 
```
curl http://apache.mirror.digionline.de/tomcat/tomcat-9/v9.0.4/bin/apache-tomcat-9.0.4.tar.gz > tomcat.tar.gz
sudo mkdir /opt/tomcat
sudo tar xzvf ~/tomcat.tar.gz -C /opt/tomcat --strip-components=1
cd /opt/tomcat
```
Write and execute rights
```
sudo chgrp -R tomcat /opt/tomcat
```
```
sudo chmod -R g+r conf 
```
Add a new User
```
sudo adduser tomcat --ingroup tomcat
sudo chown -R tomcat webapps/ work/ temp/ logs/
```

Create service:
A service is a kind of "registration" that can be used for start/stop/restart the service tomcat.

```
sudo nano /etc/systemd/system/tomcat.service
```
Copy and paste the following:
*(ATTENTION: tomcat loads these variables, not the system variables. If you point Environment=JAVA_HOME to a directory, tomcat will use this for starting)*

```
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking
Environment=JAVA_HOME=/user/lib/jvm/java-9-oracle
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
```
```
sudo systemctl daemon-reload 
sudo systemctl start tomcat
sudo systemctl enable tomcat
sudo ufw allow 8080
```
Attention: In AWS, the ports need to be enabled in the security groups: add Inbound rule for port 8080
```
sudo systemctl enable tomcat
sudo nano /opt/tomcat/conf/tomcat-users.xml
```
Add the line and change password: <user username="admin" password="password" roles="manager-gui,admin-gui"/>
here: security constraint in order to access GUI securely!
```
sudo nano /opt/tomcat/webapps/manager/META-INF/context.xml
```
Comment out by adding the yellow letters in the following 2 context.xml:  
<!--<Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />-->
```
sudo nano /opt/tomcat/webapps/host-manager/META-INF/context.xml
```
Comment out by adding the yellow letters in the following 2 context.xml:  
<!--<Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />-->
```
sudo systemctl restart tomcat
```
change password for tomcat
```
sudo passwd tomcat
```
```
sudo nano ~/.bashrc
export CLASSPATH=/usr/lib/jvm/java-9-oracle:/opt/tomcat/lib:$CLASSPATH
source ~/.bashrc 
```

## SSL Certificates for the Webapps

```
sudo $JAVA_HOME/bin/keytool -genkey -alias tomcat -keyalg RSA  -keypass imbit15 -storepass imbit15 -keystore $CATALINA_HOME/conf/tomcat-keystore.jks
```

Follow instructions and confirm with [yes]
```
cd /opt/tomcat/conf
nano server.xml
```
Copy and insert: Add to the server.xml file:


    <Connector port="8443" protocol="HTTP/1.1"
                SSLEnabled="true" maxThreads="150" scheme="https"
                secure="true" clientAuth="false" sslProtocol="TLS"
                keystoreFile="$CATALINA_HOME/conf/tomcat-keystore.jks"
                keystoreType="JKS" keystorePass="imbit15"   />

add to rc.local: --> This configures a redirect of port 443 to 8443, ATTENTION needs to be removed when using https (port 443 too).
```
sudo nano /etc/rc.local
```
the following before the line with "exit":
```
sudo iptables -t nat -I PREROUTING -p tcp --destination-port 443 -j REDIRECT --to-ports 8443 
sudo service tomcat restart
```
Reverse Proxy: port 8080 to port 8443 via localhost --> subsequently remove port 8080 on ufw 

## Install PHP:
PHP is used by brillianIDEAS and needs to be configured to work with Apache:

Install PHP:
```
sudo apt-get install php7.0-xsl libapache2-mod-php7.0
```

Edit your php.ini file (find it in PHP folder, eg. C:\xampp\php)
Change short_open_tag from "Off" to On
```
short_open_tag=On
```
Remove semicolon before extension, where something like xsl or php_xsl is defined
```
extension=xsl
```
After these steps for enabling PHP for Apache:
```
sudo a2enmod php7
sudo service apache2 reload
```

## Persistent Logging:

```
mkdir /var/log/journal
systemd-tmpfiles --create --prefix /var/log/journal
systemctl restart systemd-journald
Folgende Rechte für Log-Files wurden geändert von systemd-network zu syslog:
```
```
cd /var/log
sudo chown syslog auth.log
sudo chown syslog daemon.log
sudo chown syslog debug
sudo chown syslog dmesg
sudo chown syslog kern.log
sudo chown syslog lastlog
sudo chown syslog mail.log
sudo chown syslog syslog
sudo chown syslog user.log
sudo chown syslog uucp.log
```

## Port Freigaben:

Enable Ports: Folgende Ports werden für den Zugriff benötigt: 
Ports 22 (SSH), Port 80 (HTTP-Apache), Port 443 (HTTPS), Port 8080 (Tomcat)

check “sudo netstat -plnt” for active Internet connections
```
sudo iptables -P INPUT ACCEPT 
sudo iptables -F
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT 
sudo iptables -I INPUT -p tcp --dport 443 -j ACCEPT 
sudo iptables -I INPUT -p tcp --dport 8080 -j ACCEPT 
sudo iptables --list
```

//keine Ahnung
•	SSL certificates
o	Nginx: conf.d SSL config: will Nginx be used?????
server { 
listen 	443 ssl; 
server_name brillianicm.com www.brillianicm.com; 
ssl_certificate /etc/nginx/ssl/brillianicm.crt; 
ssl_certificate_key /etc/nginx/ssl/brillianicm.key; 
ssl_session_cache shared:SSL:1m; ssl_session_timeout 5m; 
ssl_ciphers HIGH:!aNULL:!MD5; 
ssl_prefer_server_ciphers on;
Um das vertrauenswürdige Zertifikat von geoTrust zu nutzen muss es zusammen mit dem Privatekey von 1und1.de in das PKCS12Format umgewandelt werden:
openssl pkcs12 –export in „TrustedCERT.crt“ inkey „PrivateKEY.key“ -out KEYSTORE.p12 -name "some alias"
Keytool-importkeystore -srckeystore KEYSTORE.p12 -srcstoretype PKCS12 -destkeystore TOMCAT.keystore
https://www.digitalocean.com/community/tutorials/how-to-encrypt-tomcat-8-connections-with-apache-or-nginx-on-ubuntu-16-04 

ConfirmRegistation:
https://brillianCRM.com/app/ConfirmRegistration?email=c4312551@trbvm.com&ue=28152 brillianCRM.com muss hier dann durch den richtigen Servernamen ersetzt werden.
Repositories hinzufügen??? nginx/mySQL,…

## Start von Deployment
1. Bei FTP Client anmelden (e.g. winSCP)
2. Kopiere war files in webapps Ordner / alternativ in temp folder und dann in webapps


## Issues on productive system

The following code needs to be commented on **server.xml**
```
        <Host name="www.brillianicm.com"  unpackWARs="true" autoDeploy="true">
                <Alias>www.brillianicm.com</Alias>
                <Context path="" docBase="/opt/tomcat/webapps/brillianICM" debug="0" reloadable="true" />
                <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
                   prefix="brillianICM_access_log" suffix=".txt"
                   pattern="%h %l %u %t &quot;%r&quot; %s %b" />
        </Host>

        <Host name="www.brilliancrm.com" unpackWARs="true" autoDeploy="true">
                <Alias>www.brilliancrm.com</Alias>
                <Context path="" docBase="/opt/tomcat/webapps/brillianCRM" debug="0" reloadable="true" />
                <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
                   prefix="brillianCRM_access_log" suffix=".txt"
                   pattern="%h %l %u %t &quot;%r&quot; %s %b" />
        </Host>
```

Context path in $CATALINA_HOME/webapps/brillianXXX/META-INF/context.xml:
```
<Context path="/brillianICM">
```

When configuration here is not correct, errors such as the following might ocurr: java.sql.SQLException: Cannot create JDBC driver of class '' for connect URL 'null'
