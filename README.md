# dbt-combo-test


## Le projet
Ce projet vise à adapter la stratégie de tarification de Combo, une entreprise SaaS dans le domaine des RH, à un modèle basé sur l'utilisation. À travers l'outil dbt pour la transformation de données, nous analysons les données clients pour identifier les employés et les localisations facturables chaque semaine, en fonction du nouveau modèle de tarification. Le travail implique le traitement de données issues de plusieurs fichiers CSV, couvrant des aspects tels que les comptes clients, les employés, et les localisations, pour calculer les revenus hebdomadaires prévus par compte. Ce projet met en lumière notre approche pour soutenir la transition de Combo vers une tarification plus flexible et alignée sur l'utilisation réelle de ses services par les clients.


## Installer le projet dbt
1 - Créer un environnement virtuel<br>
2 - Installer BigQuery pour dbt : `pip install dbt-bigquery`<br>
3 - Installer le fichier **profiles.yml** : `dbt init`<br>
    - Sélectionner la base de données bigquery<br>
    - service_account<br>
    - Le chemin du fichier **gcp_credentials.json**<br>
    - dataset : public<br>
4 - Faire la commande : `dbt debug`. On doit avoir le message : **All checks passed!**<br>

Pour info : Il est également possible de se connecter à BigQuery via un IDE (Datagrip ou dbEaver par exemple), avec les mêmes credentials que dans le json.<br>

ATTENTION : Pour que le projet fonctionne, il faut glisser/déposer les CSV dans le dossier **seeds**. En effet, git ne permet pas d'uploader des fichiers trop volumineux.<br>


## Questions

**1. Quel est le nombre de sites et d'employés facturables par semaine pour chaque compte ?**<br>
Le modèle fct_nb_location_and_membership_accountable_by_account permet de répondre à cette question. 
Pour l'exécuter, il suffit de faire `dbt build -s +fct_nb_location_and_membership_accountable_by_account`<br>
![DAG +fct_nb_location_and_membership_accountable_by_account](https://github.com/tho-bre/dbt-combo-test/assets/130186547/8404d240-4ac7-4099-82eb-4176e23cf489)<br><br>

**2. Quel est le revenu hebdomadaire attendu par compte avec le nouveau modèle de tarification ?**<br>
Le modèle fct_expected_weekly_income_by_account permet de répondre à cette question. 
Pour l'exécuter, il suffit de faire `dbt build -s +fct_expected_weekly_income_by_account`<br>
![DAG +fct_expected_weekly_income_by_account](https://github.com/tho-bre/dbt-combo-test/assets/130186547/4c7f6327-03f0-4147-9ee3-d4c3098e624b)<br><br>


## Conception du projet 

Tout d'abord, étant donné que nous traitons avec des fichiers CSV, je les ai placés dans des seeds dbt, car il est judicieux de procéder de cette manière. Dans un contexte réel, ces tables seraient situées dans un dataset brut. Le projet est structuré en trois parties principales :<br>
Modèles de **staging** : Ces modèles servent d'interface directe avec les sources de données.<br>
Modèles **intermédiaires** : Ils sont utilisés pour effectuer des transformations qui visent à simplifier les modèles subséquents.<br>
Modèles dans les **marts** : Ces modèles sont conçus pour fournir des insights sur Combo et répondre aux questions financières relatives au potentiel MRR, adapté sur une base hebdomadaire.<br><br>
![Structure du projet](https://github.com/tho-bre/dbt-combo-test/assets/130186547/3e0c4eb8-10fa-4dc2-9ba0-7cc2541cbc41 = 250x)<br>

J'ai volontairement omis la réalisation de tests, car cette étape n'est pas la plus complexe dans dbt, les tests étant souvent préconçus. Cependant, nous aurions pu envisager l'implémentation de tests génériques, tels que des vérifications de clés étrangères et de non-nullité. Des tests plus spécifiques auraient également pu être mis en place, par exemple pour s'assurer que le champ contract_time de la table user_contracts ne soit pas négatif.

De plus, j'ai opté pour une nomenclature des tables au singulier pour plusieurs raisons : alignement avec les bonnes pratiques de développement, notamment en programmation orientée objet (POO), ainsi que pour éviter les confusions liées aux pluriels irréguliers, comme "person" qui devient "people", par exemple.


## Mes coordonnées
**email** : tho.bremond@gmail.com<br>
**téléphone** : 06.78.12.65.47<br>