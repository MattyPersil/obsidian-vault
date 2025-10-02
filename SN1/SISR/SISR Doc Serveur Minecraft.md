---
created:
  - 2025-01-22 15:06
---
>[!info] Contact 
Nom Prénom : Monnier Matthieu
Email : matthieumm444444@gmail.com
Email Scolaire : matthieu.monnier@ecoles-epsi.net

---
- 2025-01-22 15:06 - Création initiale
---

> [!info] Sommaire
> ```table-of-contents
> ```

---
# Monter une VM à l'aide de vagrant

> [!warning] Attention
> Après multiples essais à partir de cette doc, il se trouve que je n'ai pas réussi à faire fonctionner le serveur minecraft sur une vm monté à l'aide de vagrant, je recommande de la monter via un autre moyen tel que la monter à neuf depuis virtualbox grâce à un iso de debian, ou une autre méthode donnant une vm debian basique sur laquelle travailler.
> 
> Le reste de la doc fonctionne très bien à partir d'une machine non montée depuis vagrant.

- On va chercher la vagrantfile pour monter la VM
```shell
vagrant init debian/bookworm64 --box-version 12.20241217.1
```
- On édite la vagrantfile si besoin
```shell
nano .\Vagrantfile
```
- On crée la VM
```shell
vagrant up
```
- On se connecte à la VM
```shell
vagrant ssh
```
# Monter le serveur minecraft
## Installer Java 21
- Installer la version 17
```shell
sudo apt update
sudo apt upgrade -y
sudo apt install default-jre -y
```
- Vérifier la version
```shell
java -version
```
```
# Résultat
openjdk version "17.0.13" 2024-10-15
OpenJDK Runtime Environment (build 17.0.13+11-Debian-2deb12u1)
OpenJDK 64-Bit Server VM (build 17.0.13+11-Debian-2deb12u1, mixed mode, sharing)
```
- Installer la version 21
```shell
wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
sudo apt install ./jdk-21_linux-x64_bin.deb
```
- Vérifier la version
```shell
java -version
```
```
# Résultat
java version "21.0.6" 2025-01-21 LTS
Java(TM) SE Runtime Environment (build 21.0.6+8-LTS-188)
Java HotSpot(TM) 64-Bit Server VM (build 21.0.6+8-LTS-188, mixed mode, sharing)
```

## Télécharger le programme
On accède au lien en utilisant la fonction "copier le lien" sur le lien minecraft_server.*version*.jar depuis un navigateur sur cette page :
- https://www.minecraft.net/fr-fr/download/server
```shell
wget lien
```
## Avant de lancer le serveur

> [!info] Note
> Se référer à l'étape suivante "Mettre en place le service"
> Cette étape n'est nécessaire qu'à partir de la gestion de l'automatisation du service pour gérer le serveur de façon autonome
> Si besoin il est toujours possible de déplacer les fichiers créés au bon emplacement une fois le serveur lancé une première fois

## Lancer le serveur minecraft
- Lancer pour la première fois
```shell
java -jar server.jar --nogui
```
- Editer eula.txt et passer eula à true
```shell
nano eula.txt
```
- Relancer le serveur
```Shell
java -jar server.jar --nogui
```
# Mettre en place le service avec SystemD
## Créer l'utilisateur qui gérera le service
```shell
sudo adduser --system --home /srv/minecraft-server minecraft
sudo addgroup --system minecraft
sudo adduser minecraft minecraft 
```
## Ajouter le programme dans le dossier prévu
### Si le serveur n'a pas été lancé une première fois
- Déplacer le fichier server.jar 
```shell
sudo mv server.jar /srv/minecraft-server
```
- **Retourner à l'étape Lancer le serveur minecraft**
### Si le serveur à déjà été lancé
- Déplacer tout les fichiers créés à l'aide de la commande mv (eula.txt,server.jar,logs etc...)
Exemple :
```shell
mv server.jar /srv/minecraft-server
mv eula.txt /srv/minecraft-server
mv logs /srv/minecraft-server
# etc avec tout les fichiers créés par server.jar
```
## Transférer les droits du programme à l'utilisateur créé
```shell
sudo chown -R minecraft:minecraft /srv/minecraft-server
```
## Créer le service
- Créer et éditer le fichier 
```shell
sudo nano /lib/systemd/system/minecraft-server.service
```
- Coller le contenu suivant à l'intérieur du fichier
```
[Unit]   
Description=start and stop the minecraft-server   
  
[Service]  
WorkingDirectory=/srv/minecraft-server  
User=minecraft  
Group=minecraft  
Restart=on-failure  
RestartSec=20 5  
ExecStart=/usr/bin/java -Xms1536M -Xmx1536M -jar server.jar --nogui  
  
[Install]  
WantedBy=multi-user.target
```
## Activer le service
```shell
sudo systemctl enable minecraft-server.service
```
## Lancer le service
```shell
sudo systemctl start minecraft-server.service
```
- on peut vérifier l'état du service grâce à la commande suivante
```shell
sudo systemctl status minecraft-server.service
```
- on peut également vérifier l'activité sur le serveur en y regardant ses logs : 
```shell
cat /srv/minecraft-server/logs/latest.log
```
