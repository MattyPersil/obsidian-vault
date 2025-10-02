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
# TP3
```mermaid
sequenceDiagram
    User->>Site: Recherche train
	    Site->>Site: Applique filtres
	alt Si au moins un train correspond

	    Site--)User: Affiche les trains
    loop Recherche un train
    User->>Site: Séléctionne un train
		Site->>Site: Accède aux données du train et érifie la disponibilité de la place
    alt Il reste au moins une place disponible
        Site--)User:Affiche les détails
    
    User->>Site: Envoie les données de réservation
		Site->>Site: Vérifie la disponibilité
        alt La place est disponible
        Site->>Site: Enregistre la réservation
        Site--)User: Confirme la réservation
        else La place n'est plus disponible
        Site --) User: Propose d'autres choix
        end


    else Il n'y a plus de place dans le train
        Site --) User: Propose d'autres choix

    end
    end
    else Aucun train ne correspond
    Site--)User: Affiche un message d'erreur    
    end
    
```
