# Agentic Reproducibility Base Image

FROM rocker/r-ver:4.4.1

# avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl wget git \
    gnupg ca-certificates \
    software-properties-common \
    tcl-dev tk-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libssl-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libcairo2-dev \
    pandoc \
    python3 python3-pip \
    locales && \
    locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# nodejs + gemini + opencode
RUN apt-get update && apt-get install -y curl xz-utils && \
    curl -fsSL https://nodejs.org/dist/v20.11.0/node-v20.11.0-linux-x64.tar.xz | tar -xJv -C /usr/local --strip-components=1 && \
    rm -rf /var/lib/apt/lists/*

# npm packages
RUN npm install -g @google/gemini-cli
RUN npm install -g opencode-ai
RUN npm install -g @anthropic-ai/claude-code @musistudio/claude-code-router

# working directory
RUN mkdir -p /workspace
WORKDIR /workspace

# default shell
CMD ["/bin/bash"]