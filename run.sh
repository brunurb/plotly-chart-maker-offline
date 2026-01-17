#!/bin/bash

if ! command -v docker &> /dev/null; then
    echo "Docker não está instalado. Por favor, instale o Docker Desktop a partir de https://www.docker.com/get-started"
    xdg-open "https://www.docker.com/get-started"
    exit 1
fi

if ! docker info &> /dev/null; then
    echo "Docker não está em execução. Por favor, inicie o Docker Desktop."
    exit 1
fi

# Get the current working directory
CURRENT_DIR=$(pwd)
OUTPUT_DIR="$CURRENT_DIR/output_charts"

# Create output directory on host with correct permissions
mkdir -p "$OUTPUT_DIR"
chmod 777 "$OUTPUT_DIR"

# Build the image if it doesn't exist
if ! docker image inspect chartmaker &> /dev/null; then
    echo "A construir a imagem Docker (isto pode demorar alguns minutos)..."
    docker build -t chartmaker .
fi

# Run the container with correct volume mapping
echo "A iniciar o ChartMaker. Estará disponível em http://localhost:8501"
echo "Os gráficos exportados serão guardados em: $OUTPUT_DIR"
docker run -p 8501:8501 \
    -v "$OUTPUT_DIR:/app/output_charts" \
    -e OUTPUT_DIR="/app/output_charts" \
    chartmaker

xdg-open "http://localhost:8501"

