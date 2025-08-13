FROM python:3.9-slim-bullseye

WORKDIR /app

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

COPY . .

RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["python3", "main.py"]
