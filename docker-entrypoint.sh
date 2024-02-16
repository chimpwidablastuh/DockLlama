#!/bin/sh
if [ -f .env ]; then
  export $(cat .env | xargs)
fi
# Lance ollama serve en arrière-plan
ollama serve &
# Attends un peu pour s'assurer que le serveur a démarré
sleep 10
# Continue avec les autres commandes nécessaires
ollama pull $MODEL
# Exécute le fichier index.js avec Node.js
exec node index.js
