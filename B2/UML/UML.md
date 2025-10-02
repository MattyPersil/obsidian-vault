---
created:
  - "2025-09-25 16:53"
---
>[!info] Contact 
Nom Prénom : Monnier Matthieu
Email : matthieumm444444@gmail.com
Email Scolaire : matthieu.monnier@ecoles-epsi.net

---
- 2025-09-25 16:53 - Création initiale
---

> [!info] Sommaire
> ```table-of-contents
> ```

---
# TP1
```mermaid  
sequenceDiagram
    User->>Site: Recherche train
	    Site->>Site: Applique filtres
	    Site--)User: Affiche les trains
	User->>Site: Séléctionne un train
		Site->>Site: Accède aux données du train
		Site--)User:Affiche les détails
	User->>Site: Envoie les données de réservation
		Site->>Site: Vérifie et enregistre la réservation
		Site--)User: Confirme la réservation
```

# TP2
```mermaid
  

sequenceDiagram

Utilisateur-)Bibliothèque: Requête de recherche

Bibliothèque->>BaseDedonnees: Recherche le livre

BaseDedonnees--)Bibliothèque: Réponse disponibilitée

opt Le livre est disponible

Bibliothèque--)Utilisateur: Réponse positive

Utilisateur-)Bibliothèque: Demande l'emprunt du livre

Bibliothèque->>BaseDedonnees: Vérifie la disponibilitée

BaseDedonnees--)Bibliothèque: Réponse disponibilitée

opt Le livre est disponible

Bibliothèque-)BaseDedonnees:Enregistre les détails de l'emprunt

Bibliothèque-)Notification:Informe de l'emprunt

Notification-)Utilisateur:Envoie une notification pour confirmer l'emprunt du livre

Utilisateur-)Bibliothèque: Retourne le livre

Bibliothèque-)BaseDedonnees: Enregistre le retour

Bibliothèque-)Notification: Confirme le retour

Notification-)Utilisateur: Envoie une notification de retour

end

end
```
