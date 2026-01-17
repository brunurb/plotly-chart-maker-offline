@echo off

where docker >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Docker não está instalado. Por favor, instale o Docker Desktop a partir de https://www.docker.com/get-started
    start "" "https://www.docker.com/get-started"
    exit /b 1
)

docker info >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Docker não está em execução. Por favor, inicie o Docker Desktop.
    exit /b 1
)

set OUTPUT_DIR=%USERPROFILE%\Desktop\testtt\output_charts
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

if not exist "chartmaker" (
    echo A construir a imagem Docker (isto pode demorar alguns minutos)...
    docker build -t chartmaker .
)

echo A iniciar o ChartMaker. Estará disponível em http://localhost:8501
docker run -p 8501:8501 -v "%OUTPUT_DIR%:/app/output_charts" -e OUTPUT_DIR="/app/output_charts" chartmaker

start "" "http://localhost:8501"

