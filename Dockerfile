# Updated base image (buster हटाकर bullseye लिया)
FROM python:3.9-slim-bullseye

# Working directory
WORKDIR /app

# Install system dependencies + time sync tools
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
        mediainfo \
        tzdata \
        ntpdate && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set timezone (change if needed)
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Sync time to avoid BadMsgNotification
RUN ntpdate -s time.google.com || true

# Copy project files
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Start the bot
CMD ["python3", "main.py"]
