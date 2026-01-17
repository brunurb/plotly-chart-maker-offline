# 🐧 ChartMaker - Linux Setup Guide

Complete guide for running ChartMaker on Linux distributions.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Running the Application](#running-the-application)
- [Troubleshooting](#troubleshooting)
- [Advanced Configuration](#advanced-configuration)

---

## Prerequisites

### 1. Install Docker

#### Ubuntu / Debian / Linux Mint

```bash
# Update package index
sudo apt update

# Install required packages
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index again
sudo apt update

# Install Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Verify installation
docker --version
```

#### Fedora

```bash
# Install Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker
```

#### Arch Linux

```bash
# Install Docker
sudo pacman -S docker

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker
```

### 2. Post-Installation (Optional but Recommended)

Run Docker without `sudo`:

```bash
# Add your user to the docker group
sudo usermod -aG docker $USER

# Log out and log back in for changes to take effect
# Or run this to activate in current terminal:
newgrp docker

# Verify you can run docker without sudo
docker run hello-world
```

---

## Installation

### Method 1: Git Clone (Recommended)

```bash
# Clone the repository
git clone https://github.com/brunurb/plotly-chart-maker-offline.git

# Navigate to the directory
cd plotly-chart-maker-offline

# Make the run script executable
chmod +x run.sh
```

### Method 2: Direct Download

```bash
# Download as ZIP
wget https://github.com/brunurb/plotly-chart-maker-offline/archive/refs/heads/main.zip

# Extract
unzip main.zip

# Navigate to directory
cd plotly-chart-maker-offline-main

# Make executable
chmod +x run.sh
```

---

## Running the Application

### Quick Start

```bash
# Simply run the script
./run.sh
```

The application will:
1. Check if Docker is running
2. Build the Docker image (first time only - takes ~5 minutes)
3. Start the container
4. Open your browser to `http://localhost:8501`

### Manual Steps (if you prefer)

```bash
# 1. Build the Docker image
docker build -t chartmaker .

# 2. Create output directory
mkdir -p output_charts

# 3. Run the container
docker run -p 8501:8501 \
    -v "$(pwd)/output_charts:/app/output_charts" \
    -e OUTPUT_DIR="/app/output_charts" \
    chartmaker

# 4. Open browser
xdg-open http://localhost:8501
```

### Stopping the Application

Press `Ctrl+C` in the terminal where it's running, or:

```bash
# Find the container ID
docker ps

# Stop the container
docker stop <container_id>
```

---

## Troubleshooting

### Docker daemon not running

**Error**: `Cannot connect to the Docker daemon`

**Solution**:
```bash
# Start Docker service
sudo systemctl start docker

# Enable Docker to start on boot
sudo systemctl enable docker

# Check Docker status
sudo systemctl status docker
```

### Permission denied

**Error**: `permission denied while trying to connect to the Docker daemon socket`

**Solution**:
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Log out and log back in, or run:
newgrp docker
```

### Port 8501 already in use

**Error**: `Bind for 0.0.0.0:8501 failed: port is already allocated`

**Solution 1** - Use a different port:
```bash
# Edit run.sh and change the port
docker run -p 8502:8501 ...

# Then access at http://localhost:8502
```

**Solution 2** - Find and stop the process using port 8501:
```bash
# Find process using port 8501
sudo lsof -i :8501

# Stop it
kill -9 <PID>
```

### Browser doesn't open automatically

**Solution**:
```bash
# Manually open browser
xdg-open http://localhost:8501

# Or use your preferred browser
firefox http://localhost:8501
google-chrome http://localhost:8501
```

### Docker build fails

**Error**: Various build errors

**Solution**:
```bash
# Clean Docker cache
docker system prune -a

# Rebuild without cache
docker build --no-cache -t chartmaker .
```

### Output charts not saving

**Check permissions**:
```bash
# Ensure output_charts directory exists and is writable
ls -la output_charts/

# Fix permissions if needed
chmod 777 output_charts/
```

### Container runs but app doesn't load

**Check logs**:
```bash
# View container logs
docker logs <container_id>

# Or if you know the container name
docker logs chartmaker
```

---

## Advanced Configuration

### Change Port

Edit `run.sh`:
```bash
# Change this line:
docker run -p 8502:8501 ...
```

### Custom Output Directory

```bash
# Specify a different output directory
docker run -p 8501:8501 \
    -v "/path/to/your/output:/app/output_charts" \
    -e OUTPUT_DIR="/app/output_charts" \
    chartmaker
```

### Run in Background (Detached Mode)

```bash
# Add -d flag
docker run -d -p 8501:8501 \
    -v "$(pwd)/output_charts:/app/output_charts" \
    -e OUTPUT_DIR="/app/output_charts" \
    --name chartmaker \
    chartmaker

# View logs
docker logs -f chartmaker

# Stop
docker stop chartmaker
```

### Auto-restart on System Boot

```bash
# Add --restart unless-stopped
docker run -d --restart unless-stopped \
    -p 8501:8501 \
    -v "$(pwd)/output_charts:/app/output_charts" \
    -e OUTPUT_DIR="/app/output_charts" \
    --name chartmaker \
    chartmaker
```

### Resource Limits

```bash
# Limit memory and CPU
docker run -p 8501:8501 \
    --memory="1g" \
    --cpus="1.0" \
    -v "$(pwd)/output_charts:/app/output_charts" \
    chartmaker
```

---

## Testing

### Verify Installation

```bash
# Check Docker is installed
docker --version

# Check Docker is running
docker info

# Check image is built
docker images | grep chartmaker

# Test run
./run.sh
```

### Sample Test Workflow

1. Run the application: `./run.sh`
2. Upload a sample CSV file
3. Generate a chart
4. Export it
5. Check `output_charts/` folder for the exported file

---

## Uninstalling

### Remove ChartMaker

```bash
# Stop running containers
docker stop $(docker ps -q --filter ancestor=chartmaker)

# Remove Docker image
docker rmi chartmaker

# Remove application files
cd ..
rm -rf plotly-chart-maker-offline
```

### Remove Docker (Optional)

**Ubuntu/Debian/Mint**:
```bash
sudo apt purge docker-ce docker-ce-cli containerd.io
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

**Fedora**:
```bash
sudo dnf remove docker-ce docker-ce-cli containerd.io
sudo rm -rf /var/lib/docker
```

---

## Performance Tips

1. **First run is slow** - Docker needs to download base images (~5 minutes)
2. **Subsequent runs are fast** - Image is cached locally
3. **Large CSV files** - May take longer to process
4. **Multiple exports** - Batch export is faster than individual

---

## Getting Help

- **Issues**: [GitHub Issues](https://github.com/brunurb/plotly-chart-maker-offline/issues)
- **Documentation**: Check the main [README.md](README.md)
- **Docker Help**: [Docker Documentation](https://docs.docker.com/)

---

## System-Specific Notes

### Linux Mint / Ubuntu / Debian
✅ Fully tested and supported

### Fedora / RHEL / CentOS
✅ Supported - use `dnf` instead of `apt`

### Arch Linux / Manjaro
✅ Supported - use `pacman` instead of `apt`

### Pop!_OS
✅ Supported - same as Ubuntu

### Elementary OS
✅ Supported - same as Ubuntu

---

**Happy charting! 📊**
