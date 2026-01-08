
# PIP Offline Package Downloader

Outil simple pour télécharger des paquets Python et leurs dépendances pour un usage offline.
Génère une archive `.tar.gz` prête à être importée dans un environnement offline (ex : Nexus).

## Pré-requis

*   **Docker** (et Docker Compose) installé et lancé.
*   **Make** (uniquement pour Linux/macOS).
*   Avoir configuré le fichier `config.yml` à la racine du projet.

## Installation et Configuration

1.  **Récupérez le projet et placez-vous dans le dossier :**

    ```bash
    git clone https://github.com/UnDesSix/PIP-Offline-Package-Downloader
    cd PIP-Offline-Package-Downloader
    ```

2.  **Modifiez le fichier `config.yml` selon vos besoins :**

    ```yaml
    python_version: "3.12"
    packages:
      - requests==2.31.0
      - fastapi
      - uvicorn==0.30.0
    output_archive: "packages_py.tar.gz"
    ```

---

## Utilisation

### 🐧 Linux / macOS

La commande `make` par défaut se charge de construire l'image et de lancer le téléchargement :

```bash
make
```

> **Nettoyage (optionnel) :**
> *   `make clean` : Supprime le dossier de sortie.
> *   `make purge` : Supprime le dossier et l'image Docker.

### 🪟 Windows

Utilisez **Docker Compose** (via PowerShell ou CMD) :

1.  **Construire l’image :**
    ```bash
    docker compose build
    ```

2.  **Lancer le téléchargement :**
    ```bash
    docker compose up
    ```

---

## Résultat

Une fois le processus terminé, vous trouverez l'archive contenant tous les paquets dans le dossier de sortie (par défaut `out/`) :

📂 `out/packages_py.tar.gz`

## Notes

*   Une seule version de Python par exécution.
*   Fonctionne avec un container basé sur Ubuntu 22.04.