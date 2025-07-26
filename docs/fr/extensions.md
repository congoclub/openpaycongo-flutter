# Personnalisation et Extension

Cette application a pour objectif de rester ouverte et adaptable aux différents formats de SMS Mobile Money.

## Ajouter un nouveau format
1. Ouvrez l'application et authentifiez-vous.
2. Depuis l'écran *SMS Patterns*, touchez le bouton `+` pour ajouter une règle.
3. Indiquez un nom de source (par exemple `AIRTELMONEY`).
4. Saisissez l'expression régulière permettant d'extraire les champs dans l'ordre suivant : montant, devise, nom, numéro, solde, référence.
5. Sauvegardez.

Les expressions sont stockées localement et utilisées pour analyser les SMS entrants.

## Utiliser l'assistant de construction
Si vous ne connaissez pas l'expression régulière exacte :
1. Touchez **Construire depuis un SMS**.
2. Copiez-collez un exemple de message puis indiquez les valeurs de montant, numéro, solde et référence.
3. L'expression résultante s'affiche et peut être enregistrée.

## Déploiement du backend
Consultez `installation-server.md` pour exécuter `walletd`. Les transactions reçues sont validées à partir du SMS bruts pour garantir la fiabilité.
