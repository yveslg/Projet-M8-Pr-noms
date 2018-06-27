# Projet M8 - Les prénoms

Ces programmes Matlab ont été créés dans le cadre d'un projet en Introduction à la science des données en deuxième année d'école d'ingénieur.
Ils permettent de déterminer les prénoms typiques par département et de faire des régressions entre la répartition des prénoms par département et des données socio-économiques. 

## Source des données
Les données proviennent du [fichier des prénoms de l'INSEE](https://insee.fr/fr/statistiques/2540004) 

Les données socio-économiques proviennent de [statistiques-locales.insee.fr](https://statistiques-locales.insee.fr/)

## Détails des programmes
### prenoms3d.m
Ce programme permet la convertion des données brutes (*dpt2016-brut.mat*) en une matrice tridimentionnelle pour faciliter l'exploitation de ces données.
Il permet également la recherche des prénoms les plus donnés par département.
La visualisation est possible à l'aide de la fonction *carteDpt2.m*, utilisant les fichiers dptFr provenant de OpenStreetMap pour afficher les limites des départements.
Le résultat est contenu dans *dpt2016-3D.mat*.
Le résultat sur la période 1992.2016 est contenu dans *prenoms1992-2016.mat*.

### prenomsTypiques.m
Ce programme permet de déterminer les prénoms typiques dans un département suivant les quatre critères suivants :
1. Le prénom a été le plus donné dans ce département
2. Le prénom a été donné à 50% dans ce département
3. Le prénom a été donné deux fois plus dans ce département que dans les autres
4. Le prénom a été donné deux fois plus dans ce département que la moyenne nationale

Chaque critère i correspond à une fonction Matlab *prenomsTypiqueV{i}.m*.
La visualisation des résultats sur une carte se fait à l'aide de la fonction *carteDpt.m*.

### regressionPrenoms.m
Ce programme permet des régressions entre la répartition des prénoms et des données socio-économiques contenues dans *dataINSEE.mat*.

## Dossiers
Le dossier **regressions** contient le graphe des régressions générées par le programme *regressionPrenoms.m*
Le dossier **prenoms_typiques** contient les cartes des prénoms typiques générées par le *programme prénomsTypiques.m*
