# API Examen Docker/Docker-Compose

## Problèmes rencontrés et solutions
**Problème 1** : Utiliser l'IP du conteneur pour les tests
Au début, j'avais configuré les scripts de test pour utiliser l'IP du conteneur API.
  - **Solution** : Utiliser le nom du service Docker comme URL (`api_datascientest`).

**Problème 2** : Le conteneur de test démarre avant l’API
En utilisant le nom du service, le problème était que les conteneurs de test se lançaient avant que l'API ne soit prête.
  - **Conséquences**: Les scripts plantaient car l'API n'était pas encore accessible.

**Solutions testées** :
  1. Utiliser `ping` avec `subprocess` -> Mais `ping` n'était pas disponible dans l'image Docker utilisée (`python:3.13`).
  2. Chercher une librairie Python (`pyping`) -> Bugs (d'après mes lectures cette librairie fait appel à des processus dépendant de l'hôte , je n'ai pas bien compris donc j'ai abandonné l'idée).
  3. **Solution finale** : Utiliser `requests` pour vérifier la disponibilité de l’API avec une boucle avec `requests.get()` permettant d’attendre que l’API réponde correctement.

## Autres remarques
J'ai essayé de me rapprocher d'un workflow professionnel:
  - J'ai créé des environnements virtuels pour isoler les dépendances des tests (bien qu'elles soient identiques aux trois scripts).
  - `pip freeze > requirements.txt` afin de rajouter l'étape `pip install -r requirements --no-cache-dir`


## UPDATE :
  - Après relecture de la dernière partie sur le multi-staging, j'ai modifié les Dockerfile.
  - Ce n'était pas évident car j'ai eu plusieurs bug au départ. Après quelques recherches, j'ai trouvé que les dépendances n'étaient pas installé dans le dossier /app de l'image et donc après avoir lu plusieurs topic sur StackOverflow j'ai découvert `pip -t /app/dependencies` afin d'installer les dépendances dans un dossier spécifique puis `ENV PYTHONPATH=/app/dependencies` .
  - J'ai également ajouté un .dockerignore pour éviter d'avoir à importer les `venv/`avec `COPY`.

## Conclusion 
- Bien que l'exercice n'était pas orienté sur la programmation en python, j'ai quand même pu améliorer mes compétences. J'ai passé un peu plus de temps sur les scripts parce que j'avais déjà travaillé avec Docker et Docker-Compose. Néanmoins cet exercice était quelque peu challengeant et je suis content d'en être finalement arrivé à bout.
-  En outre, je sais qu'il y a de nombreuses optimisations que je peux faire à mon travail. Par exemple, j'imagine que ce n'es pas optimal de communiquer par nom de service car l'isolation n'est pas maximal mais au vu de mes connaissances actuels ça me parrassait la meilleur solution. J'avais pensé à l'utilisation de variable d'environnement récupérant l'IP avec du parsing sur docker container inspect mais bon vu que d'abord je ne suis pas sur de savoir le faire, et qu'en plus ce n'était pas forcément ce qui était attendu dans l'exercice, j'ai abandonné l'idée pour continuer à avancer sur le programme.

-----
```
/dockerdevops_FARYOLAX
├── docker-compose.yml
├── logs
│   └── api_test.log
├── README.md
├── script.sh
├── test1
│   ├── Dockerfile
│   ├── main.py
│   ├── requirements.txt
│   └── venv
├── test2
│   ├── Dockerfile
│   ├── main.py
│   ├── requirements.txt
│   └── venv
└── test3
    ├── Dockerfile
    ├── main.py
    ├── requirements.txt
    └── venv
```
```
git clone https://github.com/RAPHTER1/datascientest_docker.git
```
