FROM python:3.9.7-slim-buster

# Work directory set करो
WORKDIR /app

# Install required system packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-utils \
        software-properties-common \
        git \
        wget \
        pv \
        jq \
        python3-dev \
        ffmpeg \
        mediainfo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Start the bot
CMD ["python3", "main.py"]
