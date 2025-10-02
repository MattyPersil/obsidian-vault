# Notes
- App travaille dans un atelier de bijouterie
- Application web (navigateur pc)
- Dans la bijouterie : plusieurs personnes avec des métiers différents,
- chaque technicien (opérateur) a un métier précis et un savoir faire précis
- clients qui demandent : fabrication de bijou (de zéro) ou à réparer / ajuster
- on donne le prix (devis) quand le client arrive (IMPORTANT) réparation : estimation actuelle puis prix réparation, création : prix de vente       si probleme pendant réparation : remboursement estimation
- Besoin : action nouveau bijou -> dessin + prix (+ image ?) (+ photo bijou avant réparation si réparation) -> désigne le premier métier (+ commentaire optionnel)
- -> lancer la fabrication dans l'atelier (saisir un premier métier)
- métiers:  fondeur (métal), sertisseur (ajout pierre / ornement), polisseur (poli les bijous (souvent dernier à intervenir)), 
- suivi des opérations par chacune des personnes sur chaque bijou (lister les actions)
- les fondeurs doivent pouvoir voir si ils ont des bijous en attente et peuvent ensuite ajouter des commentaires et décider du prochain métier qui doit intervenir (saisie)
- on enlève la vision des produits finis des opérateurs 
- aucune limite dans le nombre d'étape 
- n'importe qui peut dire que le bijou est terminé
- Bijouterie Chimère 
- de zéro
- Login Mot de passe !
- Logger non seulement le métier mais également la personne qui est intervenue


# Résumé
## Rendu :
- Application WEB pc
## Attentes :
### Profils :
- Gestion des différents métiers
- Gestion des différents utilisateurs
- Logger chaque action de chaque personne
- Un compte "administrateur" / aux accès spécifiques pour le gérant
### Actions : 
- Ajouter bijou : ajouter photo / dessin, type (création/réparation), prix (un ou deux en fonction du type)
- Désigner un métier : séléctionner un métier à qui passer le bijou
- Choisir un bijou : réserver un bijou en attente pour travailler dessus
- Commenter chaque action
- Terminer le bijou (+ Ajouter une photo du résultat final ?)
