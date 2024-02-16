# Utilise une image de base Node.js. Assure-toi de sélectionner une version spécifique si nécessaire
FROM node:latest

# Définis le répertoire de travail dans le conteneur
WORKDIR /app

# Installe curl et les dépendances nécessaires pour ollama
RUN apt-get update && apt-get install -y curl

# Installe ollama
RUN curl https://ollama.ai/install.sh | sh

# Copie ton fichier index.js (et potentiellement package.json et d'autres fichiers nécessaires) dans le répertoire de travail
COPY ./dist/index.js ./index.js

# Copier les dépendances
COPY ./package.json ./package.json

COPY .env .env

# Assure-toi que le script d'entrée est copié dans le conteneur et qu'il est exécutable
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Installe les dépendances Node.js, si tu as un package.json
RUN npm install

# Expose le port 3000
EXPOSE 3000

# Utilise le script d'entrée comme commande par défaut
CMD ["docker-entrypoint.sh"]
