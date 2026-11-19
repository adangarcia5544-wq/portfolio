#!/bin/bash
# Sirve la web en localhost para que los videos de YouTube funcionen
# (los embeds de YouTube no cargan si abres el index.html con doble clic, protocolo file://)

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORT=8080

while lsof -i ":$PORT" >/dev/null 2>&1; do
  PORT=$((PORT + 1))
done

cd "$DIR" || exit 1

echo "Sirviendo la web en http://localhost:$PORT"
echo "Pulsa Ctrl+C para detener el servidor."

open "http://localhost:$PORT/index.html"

if python3 -c "" >/dev/null 2>&1; then
  python3 -m http.server "$PORT"
else
  ruby -run -e httpd "$DIR" -p "$PORT"
fi
