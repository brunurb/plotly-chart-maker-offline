![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.8+-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=for-the-badge&logo=streamlit&logoColor=white)
![Plotly](https://img.shields.io/badge/Plotly-3F4F75?style=for-the-badge&logo=plotly&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)

![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=flat&logo=windows&logoColor=white)
![macOS](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=white)
# 📊 ChartMaker - Offline CSV to Chart Converter

A portable, offline application to create beautiful charts from CSV files using Plotly. Works on Windows, macOS, and Linux with Docker.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/docker-required-blue.svg)](https://www.docker.com/)

## ✨ Features

- 📈 **Multiple Chart Types**: Bar, Line, Scatter, Pie, and Area charts
- 🎨 **Customizable Styling**: 
  - Multiple color palettes
  - Custom backgrounds (White, Black, Transparent)
  - Adjustable text colors and labels
- 💾 **Export Options**: PNG, JPEG, SVG, and PDF formats
- 📦 **Batch Processing**: Export all charts at once
- 🌐 **Bilingual**: English and Portuguese (PT) interface
- 🔒 **Offline**: Works completely offline after initial setup
- 🐳 **Docker-based**: No Python installation required

## 🚀 Quick Start

### Prerequisites

- [Docker Desktop](https://www.docker.com/get-started) installed and running
- Any modern web browser

### Installation & Running

#### On Linux (Ubuntu, Debian, Mint, etc.)

1. **Clone or download this repository**
   ```bash
   git clone https://github.com/brunurb/plotly-chart-maker-offline.git
   cd plotly-chart-maker-offline
   ```

2. **Make the run script executable**
   ```bash
   chmod +x run.sh
   ```

3. **Run the application**
   ```bash
   ./run.sh
   ```

4. **Access the app**
   - Your browser will open automatically to `http://localhost:8501`
   - Or manually navigate to `http://localhost:8501`

#### On Windows

1. **Download and extract** this repository

2. **Double-click** `run.bat`

3. **Access the app** at `http://localhost:8501` (opens automatically)

#### On macOS

1. **Clone or download** this repository
   ```bash
   git clone https://github.com/brunurb/plotly-chart-maker-offline.git
   cd plotly-chart-maker-offline
   ```

2. **Make executable and run**
   ```bash
   chmod +x run.sh
   ./run.sh
   ```

3. **Access** at `http://localhost:8501`

## 📖 How to Use

1. **Upload CSV files** - Click "Choose CSV files" and select one or more files
2. **Choose chart type** - Bar, Line, Scatter, Pie, or Area
3. **Select color palette** - Preview and choose from available palettes
4. **Customize appearance** - Toggle labels, values, and styling options
5. **Select export format** - PNG, JPEG, SVG, or PDF
6. **Preview** - Click "Preview Charts" to see your visualizations
7. **Export** - Use "Export All Charts" for batch download or export individually

## 📂 CSV File Format

Your CSV files should have:
- **Header row** with column names
- **First column**: Categories/labels (e.g., location names)
- **Remaining columns**: Numeric data to plot

Example:
```csv
concelhos,Sim,Não,Ns/Nr
Lisboa,45,30,25
Porto,50,35,15
Faro,40,40,20
```

## 🎨 Export Formats

- **PNG**: Best for presentations and documents (raster image)
- **JPEG**: Compressed raster image
- **SVG**: Best for scaling and editing (vector image)
- **PDF**: Best for printing and reports

## 📁 Output

Exported charts are saved in the `output_charts` folder in the same directory as the application.

## 🛠️ Technical Details

### Built With

- **Streamlit** - Web application framework
- **Plotly** - Interactive charting library
- **Pandas** - Data manipulation
- **Kaleido** - Static image export
- **Docker** - Containerization

### Architecture

The application runs in a Docker container with:
- Python 3.8
- All required dependencies pre-installed
- Persistent volume for chart exports
- Port mapping to localhost:8501

### System Requirements

- **RAM**: 2GB minimum
- **Disk Space**: ~500MB for Docker image
- **OS**: Linux, Windows 7+, or macOS 10.14+
- **Docker**: Version 20.10 or higher

## 🔧 Troubleshooting

### Docker is not running
```bash
# Linux
sudo systemctl start docker

# Or start Docker Desktop on Windows/Mac
```

### Port 8501 already in use
Edit `run.sh` or `run.bat` and change the port:
```bash
# Change this line:
docker run -p 8502:8501 ...
# Then access at http://localhost:8502
```

### Permission denied on Linux
```bash
# Make script executable
chmod +x run.sh

# Or run Docker without sudo (add user to docker group)
sudo usermod -aG docker $USER
# Then log out and log back in
```

### Charts not exporting
- Check the `output_charts` folder is created
- Ensure Docker has permission to write to the directory
- Try running Docker with elevated permissions

### Browser doesn't open automatically
Manually navigate to: `http://localhost:8501`

## 🌐 Online Version

For an online version that works without installation, visit:
**[plotly-chart-maker-bbb.streamlit.app](https://plotly-chart-maker-bbb.streamlit.app/)**

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/brunurb/plotly-chart-maker-offline/issues).

## 👤 Author

**Bruno**
- GitHub: [@brunurb](https://github.com/brunurb)

## 🙏 Acknowledgments

- Built with [Streamlit](https://streamlit.io/)
- Charts powered by [Plotly](https://plotly.com/)
- Containerized with [Docker](https://www.docker.com/)

## 📸 Screenshots

![ChartMaker Interface](https://via.placeholder.com/800x400?text=ChartMaker+Interface)

---

⭐ If you find this project useful, please consider giving it a star!
