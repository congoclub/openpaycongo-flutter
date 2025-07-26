# Decentralized Payments

Ce monorepo regroupe l'application Flutter et le backend wallet en Go.
Le plugin `walletd` expose des APIs REST pour créditer un compte via les SMS Mobile Money.

## Application Flutter

L'application lit les SMS et envoie les transactions validées au backend. Elle permet d'ajouter de nouveaux formats de SMS depuis l'interface et propose un assistant pour générer une expression régulière à partir d'un exemple de message. Un écran d'authentification biométrique protège l'accès.

Voir `docs/fr/extensions.md` pour plus de détails sur l'extension des formats.
