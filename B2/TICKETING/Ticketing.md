---
created:
  - "2025-09-22 10:13"
---
>[!info] Contact 
Nom Prénom : Monnier Matthieu
Email : matthieumm444444@gmail.com
Email Scolaire : matthieu.monnier@ecoles-epsi.net

---
- 2025-09-22 10:13 - Création initiale
---

> [!info] Sommaire
> ```table-of-contents
> ```

---

# EXERCICE 1
## Création d'un container GLPI

### Création du conteneur
![[Pasted image 20250922101555.png]]
On crée donc un conteneur à l'id 2003 et à l'ip 172.16.130.41/16
![[Pasted image 20250922101933.png]]

### Mise en place du container

```bash
apt update && apt upgrade -y
apt install apache2 php mariadb-server php-xml php-common php-json php-mysql php-mbstring php-curl php-gd php-intl php-zip php-bz2 php-imap php-apcu php8.2-fpm -y

mysql_secure_installation

```
(entrer - n - n - y - y - y - y)
```bash
mysql -u root -p
```
(enter)
```mysql
CREATE DATABASE db23_glpi;
GRANT ALL PRIVILEGES ON db23_glpi.* TO glpi_adm@localhost IDENTIFIED BY "MotDePasseRobuste";
FLUSH PRIVILEGES;
EXIT
```

```bash
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
nano /var/www/glpi/inc/downstream.php
```

```php
<?php
define('GLPI_CONFIG_DIR', '/etc/glpi/');
if (file_exists(GLPI_CONFIG_DIR . '/local_define.php')) {
    require_once GLPI_CONFIG_DIR . '/local_define.php';
}
```

```bash
nano /etc/glpi/local_define.php
```

```php
<?php
define('GLPI_VAR_DIR', '/var/lib/glpi/files');
define('GLPI_LOG_DIR', '/var/log/glpi');
```

```bash
nano /etc/apache2/sites-available/support.it-connect.tech.conf
```

```php
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
```

```bash
a2ensite support.it-connect.tech.conf
a2dissite 000-default.conf
a2enmod rewrite
systemctl restart apache2

a2enmod proxy_fcgi setenvif
a2enconf php8.2-fpm
systemctl reload apache2
nano /etc/php/8.2/fpm/php.ini
```

Dans ce fichier, recherchez l'option "session.cookie_httponly" et indiquez la valeur "on" pour l'activer, afin de protéger les cookies de GLPI.

```
; Whether or not to add the httpOnly flag to the cookie, which makes it
; inaccessible to browser scripting languages such as JavaScript.
; https://php.net/session.cookie-httponly
session.cookie_httponly = on
```

```bash
systemctl restart php8.2-fpm.service

```

```
<FilesMatch \.php$>
    SetHandler "proxy:unix:/run/php/php8.2-fpm.sock|fcgi://localhost/"
</FilesMatch>
```

```bash
systemctl restart apache2
```

### Script mettant en place le glpi

![[script-glpi.sh]]

# EXERCICE 2

## ADMIN
- 
## HOTLINER
- 
## OBSERVER
- 
## READ-ONLY
- 
## SELF-SERVICE
-  Poste et suit des tickets
## SUPER-ADMIN
- Tout droits
## SUPERVISOR
- 
## TECHNICIAN
- Voit et peut répondre à des tickets

# EXERCICE 3

![[Pasted image 20250922152826.png]]
![[Pasted image 20250922152843.png]]
# EXERCICE 4

![[Pasted image 20250922152913.png]]
![[Pasted image 20250922152926.png]]
