---
created:
  - 2025-01-14 17:07
---
>[!info] Contact 
Nom Prénom : Monnier Matthieu
Email : matthieumm444444@gmail.com
Email Scolaire : matthieu.monnier@ecoles-epsi.net

---
- 2025-01-14 17:07 - Création initiale
---

# Evaluation Interrogation BDD

## 1. Afficher l’utilisateur ayant le prénom “Amaury”
```sql
SELECT * FROM client WHERE prenom = "Amaury";
```
## 2. Calculer la moyenne des prix unitaires
```sql
SELECT AVG(prix_unitaire) FROM commande_ligne;
```
## 3. Afficher la liste des villes dont le nom commence par un A.
```sql
SELECT * FROM client
WHERE ville LIKE 'A%';
```
## 4. Afficher la liste des clients par ordre alphabétique (nom et prénom).
```sql
SELECT nom,prenom FROM client
ORDER BY nom, prenom;
```
## 5. Afficher la liste des références de commande ayant eu lieu en février 2019
```sql
SELECT reference FROM commande    
WHERE date_achat LIKE "2019-02-%";
```
## 6. Modifier le prix du produit ayant pour nom “Produit 8A” en lui donnant le nouveau prix de 100 euros.
```sql
UPDATE commande_ligne 
SET prix_unitaire = 100
WHERE nom = 'Produit 8A';
```
## 7. Afficher la liste des commandes, avec le nom et prénom du client, trié par date de commande (ordre chronologique)
```sql
SELECT reference, date_achat, client.nom,client.prenom 
FROM commande
JOIN client ON commande.client_id = client.id
ORDER BY date_achat ASC;
```
## 8. Insérer un nouveau client, et ajouter lui une commande de deux produits, avec les données de votre choix (plusieurs requêtes sont nécessaires)
```sql
INSERT INTO client (prenom,nom,email,ville)
VALUES ('Jean','Robert','jeanrobert@monsupermail.fr','Saint-Tropez');

INSERT INTO commande (client_id,date_achat,reference)
VALUES (21, '2025-01-14', '003357');

INSERT INTO commande_ligne (commande_id,nom,quantite,prix_unitaire)
VALUES (49, 'Produit 42',1,50);

INSERT INTO commande_ligne (commande_id,nom,quantite,prix_unitaire)
VALUES (49, 'Produit 33',3,40);
```
Note : parcours de la base de donnée pour récupérer l'id de Jean Robert et ensuite celui de sa commande.
## 9. Afficher, pour chaque produit de la table commande_ligne, la date d’achat
```sql
SELECT nom,date_achat FROM commande_ligne
JOIN commande ON commande_ligne.commande_id = commande.id;
```
## 10. Faire une requête avec une jointure, et expliquer ce qu’elle fait
```sql
SELECT client.nom,client.prenom,date_achat FROM client
JOIN commande ON client.id = commande.client_id;
```
Cette commande permet d'afficher chaque date à laquelle un client a fait un achat
## 11. Faire une requête, et expliquer ce qu’elle fait
```sql
SELECT client.nom,client.prenom,commande_ligne.nom,commande.date_achat 
FROM client
JOIN commande ON client.id = commande.client_id
JOIN commande_ligne ON commande_ligne.commande_id = commande.id;
```
Cette commande permet d'afficher chaque produit acheté par un client avec la date de l'achat
## 12. Supprimer la commande et les lignes de commande de la commande ayant l’id 42
```sql
DELETE FROM commande_ligne WHERE commande_id = 42;
DELETE FROM commande WHERE id = 42;
```


