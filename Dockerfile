FROM ubuntu:22.04

# Avoid tzdata interactive prompt
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install core tools including tzdata
RUN apt-get update && apt-get install -y \
    tzdata \
    git curl python3 python3-pip ruby-full unzip awscli \
    nmap ansible gnupg software-properties-common && \
    # Set timezone non-interactively
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install HashiCorp repo
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update

# Install Trivy from Aqua Security
RUN curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key | \
    gpg --dearmor -o /usr/share/keyrings/trivy-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/trivy-archive-keyring.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/trivy.list && \
    apt-get update && \
    apt-get install -y trivy && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

