FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Instalar dependencias básicas
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    zip \
    unzip \
    build-essential \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Configurar el usuario vscode
USER vscode
WORKDIR /workspace

# El resto de las instalaciones (Java, Scala, etc.) se hará en setup.sh
# para mantener la flexibilidad y facilitar actualizaciones