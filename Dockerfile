# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Install Chrome (required for Kaleido)
RUN apt-get update && \
    apt-get install -y \
    wget \
    gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Create output directory with correct permissions
RUN mkdir -p /app/output_charts && chmod 777 /app/output_charts

# Copy the current directory contents into the container
COPY . .

# Install any needed packages
RUN pip install --no-cache-dir streamlit pandas plotly kaleido

# Make port 8501 available to the world outside this container
EXPOSE 8501

# Run the Streamlit app
CMD ["streamlit", "run", "plotly_chart_maker.py", "--server.port=8501", "--server.address=0.0.0.0"]

