# Carnet de Tyrie

Page d'objectifs Guild Wars 2 pour deux joueurs : carnet commun, objectifs solo,
catalogue des succès en français et progression synchronisée avec l'API du jeu.

- `index.html` : la page
- `config.js` : adresse et clé publique du projet Supabase
- `data/` : catalogue des succès, icônes et détails (API officielle Guild Wars 2)
- `supabase/setup.sql` : création de la table et des règles d'accès

Les clés API Guild Wars 2 restent dans le navigateur de chaque joueur ;
seule la liste des succès est enregistrée dans la base.
