#script ist gedacht fuer centOS/rhel ab version 7
#bitte vorher oracle JRE, Apache und MariaDB mit yum installieren. mysql_secure_installation ausführen.
#vom internet aus müssen ports 10000-10003 auf die maschine offen sein.
#scripts müssen vom root user ausgeführt werden.

#user erstellen, für den anwendungskontext
useradd pricing

#sicherstellen, dass services starten
systemctl enable mariadb
systemctl enable httpd

#ordner erstellen
mkdir /opt/mobilitypricing
mkdir /opt/mobilitypricing/provider
mkdir /opt/mobilitypricing/authority
mkdir /opt/mobiltypricing/certs
mkdir /opt/mobilitypricing/webapp
mkdir /opt/mobilitypricing/mobileapp

#scripts und konfigs kopieren
cp authority /etc/init.d/authority
cp provider /etc/init.d/provider
/bin/cp httpd.conf /etc/httpd/conf/httpd.conf
/bin/cp my.cnf /etc/my.cnf

#init.d scripts für boot registrieren
/bin/cp rc.local /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local


#anwendung kopieren
cp data/provider/* /opt/mobilitypricing/provider/
cp data/authority/* /opt/mobilitypricing/authority/
cp data/webapp/* /opt/miblitypricing/webapp/
cp data/mobileapp/* /opt/mobilitypricing/mobileapp
chmod 644 /opt/mobilitypricing/provider/*
chown pricing /opt/mobilitypricing/provider/*
chmod 644 /opt/mobilitypricing/authority/*
chown pricing /opt/mobilitypricing/authority/*


#firewall konfigurieren
firewall-cmd --add-port --add-port=80/tcp --permanent
firewall-cmd --add-port --add-port=443/tcp --permanent
firewall-cmd --add-port --add-port=10000/tcp --permanent
firewall-cmd --add-port --add-port=10001/tcp --permanent
firewall-cmd --add-port --add-port=10003/tcp --permanent
firewall-cmd --reload


#services starten
systemctl start mariadb
systemctl start httpd

#datenbankschema importieren
mysql -u root -p < schema.sql

#logrotate konfigurieren
cp logrotateauthority /etc/logrotate.d/
cp logrotateprovider /etc/logrotate.d/

echo "installation abgeschlossen. jetzt bitte die services authority und provider manuell starten oder den server rebooten"
