# PIP Offline Package Downloader

Outil simple pour télécharger des paquets Python et leurs dépendances pour un usage offline.
Génère une archive `.tar.gz` prête à être importée dans un environnement offline (ex : Nexus).

## Fonctionnalités

* Téléchargement de paquets pour une version spécifique de Python (3.11, 3.12, …).
* Résolution automatique des dépendances.
* Génération d’une archive unique pour un transfert facile.
* Configuration simple via `config.yml`.

## Utilisation

### 1. Modifier `config.yml`

Exemple :

```yaml
python_version: "3.12"
packages:
  - requests==2.31.0
  - fastapi
  - uvicorn==0.30.0
output_archive: "packages.tar.gz"
```

### 2. Construire l’image Docker

```bash
make build
```

### 3. Exécuter le container

```bash
make run
```

> Résultat : `out/packages.tar.gz` contenant tous les paquets téléchargés.

### 4. Nettoyer (optionnel)

```bash
make clean    # supprime le dossier de sortie
make purge    # supprime le dossier + l'image Docker
```

## Notes

* Nécessite une connexion internet lors du téléchargement.
* Une seule version de Python par exécution.
* Fonctionne avec un container Ubuntu 22.04.
