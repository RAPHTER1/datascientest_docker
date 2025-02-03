# API Examen Docker/Docker-Compose

## Problèmes rencontrés et solutions
**Problème 1** : Utiliser l'IP du conteneur pour les tests
Au début, j'avais configuré les scripts de test pour utiliser l'IP du conteneur API.
  - Problème : L'IP change à chaque exécution.
  - Solution : Utiliser le nom du service Docker comme URL (`api_datascientest`).

**Problème 2** : Le conteneur de test démarre avant l’API
En utilisant le nom du service, le problème était que les conteneurs de test se lançaient avant que l'API ne soit prête.
  - Conséquences: Les scripts plantaient car l'API n'était pas encore accessible.

**Solutions testées** :
  1. Utiliser `ping` avec `subprocess` -> Mais `ping` n'était pas disponible dans l'image Docker utilisée.
  2. Chercher une librairie Python (`pyping`) → Bugs
  3. Solution finale : Utiliser `requests` pour vérifier la disponibilité de l’API avec une boucle avec `requests.get()` permet d’attendre que l’API réponde correctement.

-----
## Autres remarques
J'ai essayé de me rapprocher d'un workflow professionnel:
  - J'ai créé des environnements virtuels pour isoler les dépendances des tests (bien qu'elles soient identiques aux trois scripts).
  - `pip freeze > requirements.txt` afin de rajouter l'étape `pip install -r requirements --no-cache-dir`
  
-----
## Conclusion 
Bien que l'exercice n'était pas orienté sur la programmation en python, j'ai quand même pu améliorer mes compétences. J'ai passé un peu plus de temps sur les scripts parce que j'avais déjà travaillé avec Docker et Docker-Compose

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
git clone https://github.com/RAPHTER1/datascientest_docker.git
