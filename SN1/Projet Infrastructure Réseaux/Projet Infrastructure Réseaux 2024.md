---
created:
  - "2025-02-27 08:18"
---
>[!info] Contact 
Nom Prénom :
-Marçais Emma
-Lavigne Yann
-Monnier Matthieu
Email : matthieumm444444@gmail.com
Email Scolaire : matthieu.monnier@ecoles-epsi.net

---
- 2025-02-27 08:18 - Création initiale
---

> [!info] Sommaire
> ```table-of-contents
> ```

---

Proposition pour chatons fr

---
# VMs
## ID / IP / NOM
- 1410 ; 172.16.111.1/16 ; SN1-projinfra-groupe1-WEB
- 1411 ; 172.16.111.2/16 ; SN1-projinfra-groupe1-BDD
## TEMPLATE
- 901 (debian-bookworm-sn1-1)
## CONNEXION 
- Ajouter clefs publiques SSH pour une connexion sécurisée

---
# Configurer les vms
- Commencer par update
```bash
apt update && apt upgrade -y
```
## Server BDD
- installer mariadb
```bash
apt install mariadb-server -y
```
- changer la configuration pour que la base de données soit accessible depuis l'extérieur
```bash
nano /etc/mysql/mariadb.conf.d/50-server.cnf
```
- éditer la ligne bind-adress = 127.0.0.1 à 0.0.0.0
- relancer
```bash
systemctl restart mariadb.service
```
- Se connecter à mysql
```bash
mariadb
```
- créer une base de donnée
- ici la base sera chatons
- créer un utilisateur de la base
```sql
create database chatons;
grant all privileges on chatons.* to 'chatons'@'172.16.111.1' identified by 'epsiepsi';
```
- quitter la base de donnée
```sql
exit
```
- Copier ***depuis notre machine*** la base de donnée à monter
```bash
scp bdd.sql root@172.16.111.2:
```
- retourner sur la machine base de donnée pour charger la base de donnée
```bash
cd ~
mysql chatons < bdd.sql
```
## Server WEB
- installer les paquets nécéssaires au fonctionnemment du site en php
```bash
apt install apache2 php php8.2-mysql libapache2-mod-php php8.2-gd php8.2-imagick -y
```
- Copier ***depuis notre machine*** le code du site (ici CoursPHP-BDD)
```bash
scp -r CoursPHP_BDD root@172.16.111.1:
```
- retourner sur la machine web et copier le site
```bash
cd ~
cp -r CoursPHP_BDD /var/www/
```
- Changer les droits pour plus de sécurité
```bash
chown -R www-data:www-data /var/www/CoursPHP_BDD
```
- changer la configuration d'apache pour désactiver la page par défaut
```bash
cd /etc/apache2
a2dissite 000-default
```
- créer le fichier de vhost
```bash
nano sites-availables/chatons.conf
```
- y entrer la configuration pour accéder au site copié précedemment
```
<VirtualHost *:80>
	ServerName _
	DocumentRoot /var/www/CoursPHP_BDD
	<Directory "var/www/CoursPHP_BDD/">
		Options +FollowSymLinks -Indexes
		AllowOverride all
		Require all granted
	</Directory>
	ErrorLog /var/log/apache2/error.log 
	CustomLog /var/log/apache2/acces.log combined
</Virtualhost>
```
- ensuite activer le site
```bash
a2ensite chatons.conf
```
- modifier config.php pour correspondre à la base de données
```bash
nano /var/www/CoursPHP_BDD/config.php
```
- avec ceci :
```php
<?php
class Config{
	const SERVEUR = "172.16.111.2";
	const BASEDEDONNEES = "chatons";
	const UTILISATEUR = "chatons";
	const MOTDEPASSE = "epsiepsi";
}
```
- recharger apache
```bash
systemctl reload apache2.service
```

---
# Schéma Infrastructure

![[Schéma réseau.drawio.png]]
