# Installation du serveur

Le binaire `walletd` fonctionne avec SQLite par défaut. Exemple d'exécution via Docker :

```bash
docker run -p 8080:8080 -v $(pwd)/data:/data ghcr.io/example/walletd:1.0
```

L'API expose des routes `/api/credits`, `/wallet/{phone}/debit` ainsi que la gestion des parsers (`/parsers`).
