---
created:
  - 2024-12-19 11:35
---
>[!info] Contact 
Nom Prénom : Monnier Matthieu
Email : matthieumm444444@gmail.com
Email Scolaire : matthieu.monnier@ecoles-epsi.net

---
- 2024-12-19 11:35 - Création initiale
---

> [!info] Sommaire
> ```table-of-contents
> ```

---

>[!info] Note : 
>Je n'ai pas retrouvé le fichier de base, j'ai donc refais la documentation aujourd'hui (19-12-2024).
>

---
# On commence par aller chercher le fichier hosts pour le modifier et ajouter le nom de domaine que l'ont veut
## Aller chercher le fichier

![[Pasted image 20241219113758.png]]

Pour modifier le fichier hosts à l'adresse `C:\Windows\System32\drivers\etc\hosts`
## Le modifier en suivant : "127.0.0.1 nomdu.site"

![[Pasted image 20241219113945.png]]
Ici le site de cet exercice est la ligne "127.0.0.1 monnier.matthieu"

# Ranger le site pour pouvoir y accéder
## Créer le fichier 
![[Pasted image 20241219114146.png]]
ici il est donc à l'adresse `C:\wamp64\www\Coucou\index.html`
## Le remplir pour simplement afficher Nom et Prénom

```html
<!doctype html>  
<html lang="en">  
<head>  
    <title>Monnier.Matthieu</title>  
</head>  
<body>  
    <h1>Coucou</h1>  
    <h2>- Monnier Matthieu</h2>  
</body>  
</html>
```
# Créer un virtalhost avec Wamp
## Ouvrir le fichier virtualhost
![[Pasted image 20241219114800.png]]![[Pasted image 20241219114833.png]]
## Y ajouter le code permettant d'associer l'adresse au site
```
<VirtualHost *:80>  
    DocumentRoot "C:\wamp64\www\Coucou"  
    ServerName monnier.matthieu  
</VirtualHost>
```
Il sera donc accessible sur le port 80 (en http), au nom monnier.matthieu et au chemin du site
# Tester le bon fonctionnement 
## Taper "`http://nomdu.site`"
![[Pasted image 20241219115224.png]]
On peut ici constater le bon fonctionnement
 