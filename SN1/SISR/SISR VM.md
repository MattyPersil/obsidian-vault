---
created:
  - 2025-01-21 16:20
---
>[!info] Contact 
Nom Prénom : Monnier Matthieu
Email : matthieumm444444@gmail.com
Email Scolaire : matthieu.monnier@ecoles-epsi.net

---
- 2025-01-21 16:20 - Création initiale
---

> [!info] Sommaire
> ```table-of-contents
> ```

---
# Reference

> [!check] Mess discord
> 
> Pour les <@&1295651671342317568> SISR.
> Pour la prochaine session qui est le 22 Janvier.
> Exercice pour s'entrainer et apprendre (objectif aller le plus loin possible, n'hésitez pas a poser des questions ici en cas de blocage)
> 1. Installer une VM Debian.
> 	  Le lien du fichier ISO https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.8.0-amd64-netinst.iso
> 1. Installer la machine sans interface graphique.
> 2. Creer un utilisateur.
> 3. Installer SUDO.
> 4. Ajouter votre nouvel utilisateur a la liste des SUDOers.
> 5. Pouvoir se connecter à la machine en SSH avec putty.
> 6. Configurer le serveur SSH pour obliger l'utilisation de clef SSH.
> 7. Configurer une clef SSH pour votre utilisateur et se connecter avec depuis votre OS avec Putty.
> 8. Passer en root, créer deux fichiers avec le compte root. Changer le propriétaire du premier fichier et changer les droits du deuxième pour que le compte créer précédemment puisse écrire dedans.
> 
> Essayer de ne pas vous contenter de suivre un tuto. Essayez de comprendre a quoi servent les choses. Notez. vos questionnements. Essayez d'expliquer ce que vous faites et pourquoi vous le faites entre vous ou au moins a voix haute, de façon simple. ça aide à mieux comprendre.

---
# Application
## 1. Installer une VM Debian.

![[__ Cours Vagrant.pdf]]

## 2. Installer la machine sans interface graphique.

> [!Note] Installation 
>  - Utilisation de virtual box
>  - Utilisation de la doc vagrant 
## 3. Créer un utilisateur.

### Lancer la VM
- Lancer virtual box
- commande `vagrant up` dans un terminal positionné à l'endroit du fichier
- commande `vagrant ssh` dans un terminal pour se connecter à la VM
### Créer l'utilisateur
- commande `sudo useradd potiron` pour créer l'utilisateur nommé potiron
### Vérifier la création de l'utilisateur
- commande `sudo id potiron` pour vérifier les détails de l'utilisateur
```bash
vagrant@bullseye:~$ sudo id potiron
uid=1001(potiron) gid=1001(potiron) groups=1001(potiron)
```
### J'ai enlevé le mot de passe pour le compte
```shell
sudo passwd -d potiron
```
## 4. Installer SUDO.
## 5. Ajouter votre nouvel utilisateur a la liste des SUDOers.
### Ajout
- commande `sudo adduser potiron sudo` pour l'ajouter au groupe des SUDOers
```shell
vagrant@bullseye:~$ sudo adduser potiron sudo
Adding user `potiron' to group `sudo' ...
Adding user potiron to group sudo
Done.
```
### Vérification 
- commande `sudo id potiron` pour vérifier les détails de l'utilisateur
```bash
vagrant@bullseye:~$ sudo id potiron
uid=1001(potiron) gid=1001(potiron) groups=1001(potiron),27(sudo)
```
## 6. Pouvoir se connecter à la machine en SSH avec putty.
### Install the putty package
- https://www.putty.org
### Utiliser PuttyGen pour générer une clé RSA 
![[Pasted image 20250122112939.png]]
![[Pasted image 20250122112958.png]]
### Utiliser le Terminal connecté à potiron pour créer dans son dossier utilisateur : 
- dossier .ssh
- y créer le fichier authorized_key
- y coller la clé publique générée par puttygen
### Sauvegarder la clé privé de puttygen à un endroit accessible
## Lancer l'application Putty
- Ajouter la clé privé sauvegardée
![[Pasted image 20250122113257.png]]
- ajouter l'utilisateur potiron en configuration de putty
![[Pasted image 20250122113507.png]]
- ouvrir la session grâce à putty
![[Pasted image 20250122113530.png]]
### 7. Passer en root, créer deux fichiers avec le compte root. Changer le propriétaire du premier fichier et changer les droits du deuxième pour que le compte créer précédemment puisse écrire dedans.

### Passer en root
```shell
sudo su
```
### Créer deux fichiers
![[Pasted image 20250122115201.png]]
(ignorer ligne chown vagrant premierfichier)