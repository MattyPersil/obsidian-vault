---
created:
  - 2024-12-19 13:51
---
>[!info] Contact 
Nom Prénom : Monnier Matthieu
Email : matthieumm444444@gmail.com
Email Scolaire : matthieu.monnier@ecoles-epsi.net

---
- 2024-12-19 13:51 - Création initiale
---

> [!info] Sommaire
> ```table-of-contents
> ```

---

```sql
SELECT COUNT(*) AS Effectif,marques.nom AS Marque,modeles.nom AS Modele FROM proprietaires
JOIN voitures ON proprietaires.id = voitures.proprietaire_id
JOIN modeles ON modeles.id = voitures.modele_id
JOIN marques ON marques.id = modeles.marque_id
GROUP BY modeles.nom
ORDER BY COUNT(*) DESC;
```


# Tout propriétaires avant 1 janvier 1970
```sql
SELECT * FROM proprietaires
WHERE ddn < "1970-01-01"
ORDER BY ddn ASC;
```
# Tout propriétaires nés en 1970 
```sql
SELECT * FROM proprietaires
WHERE ddn BETWEEN "1970-01-01" AND "1970-12-31";
```
# Ajouter Bordeaux
```sql
INSERT INTO villes (nom,departement) VALUES('Bordeaux',33)
```
# Ajouter et modifier Tesla
```sql
INSERT INTO marques (nom) VALUES ('tesla')
UPDATE marques SET nom = "Trump-Tesla" WHERE id=9
```
# Supprimer Trump-Tesla, Bordeaux et Nous
```sql
DELETE FROM marques WHERE id = 9;
DELETE FROM villes WHERE id = 26;
DELETE FROM proprietaires WHERE id = 181;
```

# Supprimer tout les Jean-
```sql
DELETE FROM proprietaires WHERE prenom LIKE 'Jean-%';
```


```sql 
SELECT proprietaires.nom, proprietaires.prenom, voitures.immatriculation,modeles.nom AS 'modele'
FROM voitures 
LEFT JOIN proprietaires ON voitures.proprietaire_id = proprietaires.id
INNER JOIN modeles ON voitures.modele_id = modeles.id  
```

