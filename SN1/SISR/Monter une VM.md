---
created:
  - "2025-02-26 19:12"
---
>[!info] Contact 
Nom Prénom : Monnier Matthieu
Email : matthieumm444444@gmail.com
Email Scolaire : matthieu.monnier@ecoles-epsi.net

---
- 2025-02-26 19:12 - Création initiale
---

> [!info] Sommaire
> ```table-of-contents
> ```

---
# Objectifs
- Monter une VM
- OS : Debian 12
- Outils : Virtual box
---
# Prérequis
- Avoir Virtualbox
- Télécharger un ISO de Debian 12
---
# Etapes :
## Créer la vm dans virtual box 
- Bouton "New"
![[Pasted image 20250226191545.png]]
- Séléctionner l'ISO de debian et le répertoire pour stocker la vm
- Cocher "Skip unnattended installation"
![[Pasted image 20250226191729.png]]
- Séléctionner un hardware voulu
![[Pasted image 20250226192049.png]]
![[Pasted image 20250226192223.png]]
-  Confirmer la création
![[Pasted image 20250226192306.png]]
## Lancer et finir l'installation
- Séléctionner Install
![[Pasted image 20250226192431.png]]
- Choisir la langue, région et clavier voulu (Ici anglais, france et français)
- Choisir un hostname et laisser le nom de domaine vide (ici hostname = debian)
- Choisir un mot de passe solide pour le compte root (ici RTYfghvbn@666)
- Faire de même pour la création du user (ici name=debian et password=RTYfghvbn@666)
- Après le téléchargement choisir guide user entire disk
![[Pasted image 20250226192815.png]]
-  Choisir l'unique partition présente
- Confirmer l'installation dans la partition dans les menus suivants
- Ne pas scanner pour un autre media
![[Pasted image 20250226193212.png]]
- Séléctionner l'achive debian, ici France et deb.debian.org, laisser vide pour proxy ensuite
- puis installer le reste en enlevenat tout interface graphique et installant apache (server web) et ssh (server ssh)