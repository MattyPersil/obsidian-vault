---
created:
  - 2024-12-18 14:18
---
>[!info] Contact 
Nom Prénom : Monnier Matthieu
Email : matthieumm444444@gmail.com
Email Scolaire : matthieu.monnier@ecoles-epsi.net

---
- 2024-12-18 14:18 - Création initiale
---

> [!info] Sommaire
> ```table-of-contents
> ```

---

# Code utilisé
```powershell
#je chope les infos

$nom = [System.Environment]::UserName

$nommachine = [System.Environment]::COMPUTERNAME

$date = Get-Date -Format "dd/MM/yyyy"

$heure = Get-Date -Format "HH:mm:ss"

$tempsdepuisdemarrage = (get-computerinfo).osuptime

$heuredemarrage = [math]::truncate($tempsdepuisdemarrage.TotalHours)

$minutedemarrage = [math]::truncate($tempsdepuisdemarrage.TotalMinutes) - $heuredemarrage*60

$espacelibre = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object FreeSpace

  

#j'affiche

Write-Host "Bienvenue, $nom"

Write-Host "Nom de la machine : $nommachine"

Write-Host "Date et heure : $date $heure"

Write-Host "Temps depuis le dernier demarrage : $heuredemarrage heures $minutedemarrage minutes"

Write-Host "Espace disque libre sur C: : $([math]::Truncate($espacelibre.FreeSpace / 1GB)) GB"

  

# fichier créé et rempli

$pathfichier = "C:\Temp\monFichier.txt"

$nomPrenom = "Monnier Matthieu"

New-Item -ItemType File -Path $pathfichier -Force

Add-Content -Path $pathfichier -Value $nomPrenom

  

#j'affiche

Get-Content -Path $pathfichier
```
# Affichage du script précédent :

![[Pasted image 20241218152707.png]]
# Comment lancer le script au démarrage de la session
## Ouvrir le planificateur de tache 
![[Pasted image 20241218152823.png]]
## Créer une nouvelle tache 
![[Pasted image 20241218153011.png]]
## Donner un nom et ajouter un Déclencheur
![[Pasted image 20241218153156.png]]
## Ajouter le script en action 
![[Pasted image 20241218153612.png]]

## Ensuite enregistrer la tache
