# **Partie 1 : Analyse fonctionnelle et identification des entités (10 points)**
## Question 1 : Identifiez les entités principales et leurs attributs respectifs. Précisez les attributs obligatoires et facultatifs. (5 points)

> [!Précisez les attributs obligatoires et facultatifs]  
> Utilisation de O et F pour Obligatoire et Facultatif
### **Événement**  
- idEvenement (O)
- titre (O)
- description (O)
- date de début (O)
- date de fin (O)
### **Participant** 
- idParticipant (O)
- entreprise (O)
- poste occupé (O)
### **Inscription**
- idInscription (O)
- date d'inscription (O)
- statut (O)
- code promotionnel (F)
### **Organisateur**
- idOrganisateur (O)
### **Personne** 
- IdPersonne (O)
- nom (O)
- prénom (O)
- email (O)
- numéro de téléphone (O)
### **Société**
- idSociete (O)
- nom (O)
- adresse (O)
- contact (O)
### **Intervenant**
- idIntervenant (O)
- domaine expertise (O)
### **Session**
- idSession (O)
- titre (O)
- durée (O)
- heure de début (O)
### **Salle**
- numéro de la salle (O)
- capacité (O)
### **Equipement** 
- idEquipement (O)
- équipement spécifique (O)
### **Lieu**
- idLieu (O)
- type (O)
- nom (O)
- adresse (O)
- capacité (O)
### **Fournisseur**
- idFournisseur (O)
- nom (O)
- adresse (O)
- contact (O)
### **Prestations**
- idPrestation (O)
- prestation proposé (O)
### **Factures**
- numéro de la facture (O)
- date (O)
- montant (O)
- statut (O)
### **Contact**
- IdContact
---
## **Question 2 : Identifiez les relations principales entre les entités. Précisez les cardinalités minimales et maximales pour chaque relation. (5 points)**

### Événement et Inscription
- Un événement peut avoir de 0 à plusieurs inscriptions donc 0,N
- Une inscription correspond à un événement donc 1,1
### Événement et Organisateur 
- Un événement peut avoir de 1 à plusieurs organisateurs donc 1,N
- Un organisateur peut organiser de 1 à plusieurs événements donc 1,N
### Événement et Session 
- Un événement peut avoir de 1 à plusieurs sessions donc 1,N
- Une session n'est qu'a un événement donc 1,1
### Événement et Fournisseur 
- Un événement peut avoir de 0 à plusieurs fournisseurs donc 0,N
- Un fournisseur peut fournir de 0 à plusieurs événements donc 0,N
### Inscription et Participant 
- Une inscription correspond à un seul participant donc 1,1
- Un participant peut faire de 1 à plusieurs inscriptions donc 1,N
### Organisateur et Société + Personne
On a un héritage XT car un organisateur est soit une société, soit une personne mais pas les deux ni aucun
### Session et Salle
- Une session a une salle donc 1,1
- Une salle peut servir de 0 à plusieurs sessions donc 0,N
### Salle et Lieu
- Une salle se trouve dans un lieu donc 1,1
- Un Lieu peut contenir plusieurs salles donc 1,N
### Salle et Equipement 
- Une salle peut disposer de 0 à plusieurs équipements donc 0,N
- Un Equipement peut être présent dans plusieurs salles donc 1,N
### Facture et Inscription
- Une facture concerne une seule inscription donc 1,1
- Une inscription peut avoir une facture donc 0,1
### Fournisseur et Prestation
- Un fournisseur peut fournir de 1 à plusieurs prestations donc 1,N
- Une prestation peut être fournie par 0 à plusieurs fournisseur donc 0,N
### Session et Intervenant
- Une session a de 0 à plusieurs intervenants donc 0,N
- Un intervenant peut intervenir sur 1 à plusieurs sessions donc 1,N
### Session et Intervenant
- Une session possède un intervenant principal donc 1,1
- Un intervenant peut intervenir en principal de 0 à plusieurs sessions donc 0,N
### Intervenant et Personne
- Un intervenant est une personne donc 1,1
- Une personne peut être ou ne pas être un intervenant donc 0,1
### Participant et Personne
- Un participant est une personne donc 1,1
- Une personne peut être ou ne pas être un participant donc 0,1
### Fournisseur et Contact
- Un fournisseur a un contact donc 1,1
- Un contact peut désigner de 1 à plusieurs fournisseurs donc 1,N
### Sponsor et Contact
- Un sponsor a un contact donc 1,1
- Un contact peut désigner de 1 à plusieurs Sponsor donc 1,N
### Société et Contact
- Une société a un contact donc 1,1
- Un contact peut désigner de 1 à plusieurs Société donc 1,N

---
# Partie 2 : Construction du MCD (20 points)

> [!MCD]  
> Voir fichier "TP noté.drawio"

--- 
# Partie 3 : Extensions et évolutions du MCD (20 points)

## Question 4 : Gestion des sponsors (10 points)
### **Sponsor**
- IdSponsor (O)
- nom (O)
- adresse (O)
- logo (O)
- contact (O)
### Sponsor et événement
- Un sponsor peut sponsoriser de 1 à plusieurs événements donc 1,N
- Un événement peut être sponsorisé par 0 à plusieurs sponsors donc 0,N

>[!Tables et relations]
> Voir fichier "TP noté.drawio"


## Question 5 : Gestion des certificats de participation (10 points)
### **Certificat**
- idCertificat (O)
- date d'émission (O)
- signature (O)
### Certificat et Participant
- Un certificat sert pour un seul participant donc 1,1
- Un participant peut avoir de 1 à plusieurs certificats donc 1,N
## Certificat et Evénement
- Un certificat set pour un seul événement donc 1,1
- Un événement peut avoir de 0 à plusieurs certificats donc 0,N

>[!Tables et relations]
> Voir fichier "TP noté.drawio"