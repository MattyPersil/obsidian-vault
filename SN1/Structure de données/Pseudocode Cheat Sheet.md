### 1. **Déclaration des Variables**

```plaintext
Entier x, y
Réel z
Caractère lettre
Chaîne nom
Booléen estVrai
Tableau[10] de Entier nombres
```

### 2. **Entrée / Sortie**

```plaintext
Ecrire("Bonjour !")
Ecrire("Entrez un nombre : ")
Lire(x)
```

### 3. **Opérations de Base**

```plaintext
somme <- a + b
produit <- a * b
soustraction <- a - b
division <- a / b
modulo <- a % b
```

### 4. **Structures Conditionnelles**

```plaintext
Si (x > 0) Alors
    Ecrire("x est positif")
Sinon Si (x < 0) Alors
    Ecrire("x est négatif")
Sinon
    Ecrire("x est nul")
Fin Si
```

### 5. **Boucles**

#### 5.1 Boucle Tant Que (While)

```plaintext
Tant Que (x < 10) Faire
    Ecrire(x)
    x <- x + 1
Fin Tant Que
```

#### 5.2 Boucle Pour (For)

```plaintext
Pour i <- 1 Jusqu'à 10 Faire
    Ecrire(i)
Fin Pour
```

#### 5.3 Boucle Répéter… Jusqu’à (Do While)

```plaintext
Répéter
    Ecrire(x)
    x <- x + 1
Jusqu'à (x = 10)
```

### 6. **Fonctions et Procédures**

#### 6.1 Définition d’une Fonction

```plaintext
Fonction Somme(a, b) : Entier
Début
    Retourner a + b
Fin Fonction
```

#### 6.2 Définition d’une Procédure

```plaintext
Procédure AfficherMessage(message)
Début
    Ecrire(message)
Fin Procédure
```

#### 6.3 Appel d’une Fonction ou d’une Procédure

```plaintext
resultat <- Somme(5, 3)
AfficherMessage("Bonjour")
```

### 7. **Tableaux et Parcours**

```plaintext
Tableau[5] de Entier notes <- {12, 15, 9, 18, 14}

Pour i <- 0 Jusqu'à 4 Faire
    Ecrire("Note ", i, " : ", notes[i])
Fin Pour
```

### 8. **Algorithme Complet : Somme de N Premiers Nombres**

```plaintext
Algorithme SommeNombres
Début
    Ecrire("Entrez un nombre : ")
    Lire(n)
    somme <- 0
    
    Pour i <- 1 Jusqu'à n Faire
        somme <- somme + i
    Fin Pour
    
    Ecrire("La somme des ", n, " premiers nombres est : ", somme)
Fin
```

---

Cette **cheat sheet** couvre les bases du pseudo-code et peut être utilisée comme référence rapide pour l'enseignement et l'apprentissage des algorithmes. 🚀