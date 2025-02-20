FROM paidax/dev-containers:cuda11.6-py3.8

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && \
    apt install -y \
    ffmpeg && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Winfredy/SadTalker.git && \
    pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113 && \
    cd SadTalker && \
    mkdir checkpoints && \
    mkdir -p gfpgan/weights && \
    pip install -r requirements.txt && \
    pip install \ 
    fastapi[all] \
    onnxruntime-gpu \
    loguru && \
    rm -rf /root/.cache/pip/*  # 清除pip缓存

RUN pip install httpcore==0.15
RUN pip install --upgrade pip
# RUN pip install TTS==0.14.3
RUN pip install git+https://github.com/suno-ai/bark.git
RUN pip install git+https://github.com/huggingface/transformers.git

WORKDIR /home/SadTalker
RUN ls -a
COPY main.py sadtalker_default.jpeg ./
COPY greeting.mpeg face.jpg ./
COPY src/ src/
