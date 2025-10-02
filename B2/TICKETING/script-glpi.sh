#!/bin/sh

apt update && apt upgrade -y
apt install apache2 php mariadb-server php-xml php-common php-json php-mysql php-mbstring php-curl php-gd php-intl php-zip php-bz2 php-imap php-apcu php8.2-fpm -y


DB_NAME="db23_glpi"
DB_USER="glpi_adm"
DB_PASS="MotDePasseRobuste"
ROOT_PASS=""


mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$ROOT_PASS';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
UPDATE mysql.user SET Host='localhost' WHERE User='root' AND Host!='localhost';
FLUSH PRIVILEGES;
EOF

mysql -u root -p"$ROOT_PASS" <<EOF
CREATE DATABASE $DB_NAME;
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
FLUSH PRIVILEGES;
EXIT
EOF

cd /tmp
wget https://github.com/glpi-project/glpi/releases/download/10.0.10/glpi-10.0.10.tgz
tar -xzvf glpi-10.0.10.tgz -C /var/www/
chown www-data /var/www/glpi/ -R
mkdir /etc/glpi
chown www-data /etc/glpi/
mv /var/www/glpi/config /etc/glpi
mkdir /var/lib/glpi
chown www-data /var/lib/glpi/
mv /var/www/glpi/files /var/lib/glpi
mkdir /var/log/glpi
chown www-data /var/log/glpi

cat <<EOF > /var/www/glpi/inc/downstream.php
<?php
define('GLPI_CONFIG_DIR', '/etc/glpi/');
if (file_exists(GLPI_CONFIG_DIR . '/local_define.php')) {
    require_once GLPI_CONFIG_DIR . '/local_define.php';
}
EOF

cat <<EOF > /etc/glpi/local_define.php
<?php
define('GLPI_VAR_DIR', '/var/lib/glpi/files');
define('GLPI_LOG_DIR', '/var/log/glpi');
EOF

cat <<EOF >  /etc/apache2/sites-available/support.it-connect.tech.conf
<VirtualHost *:80>
    ServerName support.it-connect.tech

    DocumentRoot /var/www/glpi/public

    # If you want to place GLPI in a subfolder of your site (e.g. your virtual host is serving multiple applications),
    # you can use an Alias directive. If you do this, the DocumentRoot directive MUST NOT target the GLPI directory itself.
    # Alias "/glpi" "/var/www/glpi/public"

    <Directory /var/www/glpi/public>
        Require all granted

        RewriteEngine On

        # Redirect all requests to GLPI router, unless file exists.
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteRule ^(.*)$ index.php [QSA,L]
    </Directory>
    <FilesMatch \.php$>
	    SetHandler "proxy:unix:/run/php/php8.2-fpm.sock|fcgi://localhost/"
	</FilesMatch>
</VirtualHost>
EOF

a2ensite support.it-connect.tech.conf
a2dissite 000-default.conf
a2enmod rewrite
systemctl restart apache2

a2enmod proxy_fcgi setenvif
a2enconf php8.2-fpm
systemctl reload apache2

sed -i 's/session.cookie_httponly =/session.cookie_httponly = on/g'  /etc/php/8.2/fpm/php.ini

systemctl restart php8.2-fpm.service
systemctl restart apache2
