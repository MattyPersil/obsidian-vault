---
created:
  - 2025-01-30 08:18
---
>[!info] Contact 
Nom Prénom : Monnier Matthieu
Email : matthieumm444444@gmail.com
Email Scolaire : matthieu.monnier@ecoles-epsi.net

---
- 2025-01-30 08:18 - Création initiale
---

> [!info] Sommaire
> ```table-of-contents
> ```

---
# Cours Sécuriser un serveur web

## Installer le serveur
- Commandes éxécutées (ip pour la vm en mon nom)
```shell
ssh root@172.16.118.212
apt update
apt upgrade
```
## Installer Apache/PHP/MySQL
- Commandes éxécutées
```shell
apt install apache2 maraidb-server php
```
## Installer Wordpress
### Prérequis
- Commandes éxécutées
```shell
a2enmod rewrite
systemctl restart apache2.service
systemctl status apache2.service
```
### Wordpress
- Commandes éxécutées
```shell
wget https://fr.wordpress.org/latest-fr_FR.zip
apt install unzip
unzip latest-fr_FR.zip
mv wordpress/ /var/www/
cd /var/www/ 
nano /etc/apache2/sites-available/000-default.conf
```
- éditer la ligne :
	- DocumentRoot /var/www/html 
	- DocumentRoot /var/www/wordpress
- Commandes éxécutées
```shell
systemctl reload apache2.service
apt install php-mysql -y
mysql
```
- Commandes sql éxécutées
```sql
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES; EXIT;
```
- Commandes éxécutées
```shell
chown -R www-data:www-data wordpress/
```