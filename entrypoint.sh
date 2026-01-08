#!/usr/bin/env bash
set -euo pipefail

# 1. Define the key directly in the script
SIGNATURE_KEY="8VFGpiIQ95JnFwofNU2O73vSviUGgvRT"

CONFIG_FILE="/app/config.yml"

PYTHON_VERSION=$(yq '.python_version' "$CONFIG_FILE" | tr -d '"')
OUTPUT_ARCHIVE=$(yq '.output_archive' "$CONFIG_FILE" | tr -d '"')
PACKAGES=$(yq '.packages[]' "$CONFIG_FILE" | tr -d '"')

echo "=== Configuration détectée ==="
echo "Python version : $PYTHON_VERSION"
echo "Output archive  : $OUTPUT_ARCHIVE"
echo "Packages        :"
echo "$PACKAGES"
echo "Signature Key   : $SIGNATURE_KEY"
echo "==============================="

echo "[1/4] Installation de Python $PYTHON_VERSION..."
add-apt-repository -y ppa:deadsnakes/ppa >/dev/null
apt-get update -qq
apt-get install -y python${PYTHON_VERSION} python${PYTHON_VERSION}-venv >/dev/null

update-alternatives --install /usr/bin/python python /usr/bin/python${PYTHON_VERSION} 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${PYTHON_VERSION} 1

echo "[2/4] Installation de pip..."
curl -sS https://bootstrap.pypa.io/get-pip.py | python${PYTHON_VERSION}

mkdir -p /tmp/wheels /output

echo "[3/4] Téléchargement des paquets..."
for pkg in $PACKAGES; do
    echo "---- Téléchargement de $pkg ----"
    python${PYTHON_VERSION} -m pip download "$pkg" -d /tmp/wheels
done

echo "Génération du fichier signature.key..."
echo -n "$SIGNATURE_KEY" > /tmp/wheels/signature.key

echo "[4/4] Création de l’archive..."

# Préparer structure out/
rm -rf /tmp/archive
mkdir -p /tmp/archive/out
cp -r /tmp/wheels/* /tmp/archive/out/

# Créer packages.tar (non compressé)
tar -cf /tmp/archive/packages.tar -C /tmp/archive out

# Compresser en .tar.gz
gzip -c /tmp/archive/packages.tar > /output/${OUTPUT_ARCHIVE}

chmod -R a+rw /output

echo "Terminé : archive disponible dans /out/${OUTPUT_ARCHIVE}"