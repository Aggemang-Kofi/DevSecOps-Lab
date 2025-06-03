
# DevSecOps Lab Setup

This project contains a local DevSecOps lab environment running on Docker Compose, including tools like OWASP Juice Shop and a custom tools container with security utilities.

---

## Tools & Services

- **Juice Shop**: A deliberately vulnerable web application for security training.
- **Tools Container**: Custom Ubuntu-based container with tools like:
  - `git`, `curl`, `python3`, `pip`, `ruby`, `nmap`, `ansible`, `awscli`, `trivy`, etc.

---

##  Prerequisites

Ensure the following are installed on your **Ubuntu** host machine:

- Docker: [Install Guide](https://docs.docker.com/engine/install/ubuntu/)
- Docker Compose: [Install Guide](https://docs.docker.com/compose/install/linux/)

Check installation:

```bash
docker --version
docker compose version
````

---

##  Setup Instructions

1. **Clone the repository**

```bash
git clone git@github.com:yourusername/devsecops-lab.git
cd devsecops-lab
```

2. **Build and Start Containers**

```bash
docker compose up --build -d
```

3. **Access Tools Container**

```bash
docker exec -it devsecops-tools bash
```

4. **Access Juice Shop App**

Open your browser and go to:

```
http://localhost:3000
```

---

## Project Structure

```
devsecops-lab/
├── Dockerfile              # Custom tools container build
├── docker-compose.yml      # Compose setup for all services
└── README.md               # Documentation
```

---

## Dockerfile Overview

Installs tools like:

```dockerfile
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git curl python3 python3-pip ruby-full unzip awscli \
    nmap ansible gnupg software-properties-common

# Add HashiCorp & Trivy repos
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update

# Install Trivy (Aqua Security)
RUN curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add - && \
    echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/trivy.list && \
    apt-get update && \
    apt-get install -y trivy

WORKDIR /workspace
```

---

## Notes

* You can extend the lab by adding tools like ZAP, SonarQube, Jenkins, or GitLab.
* Juice Shop is intentionally vulnerable—**do not expose to the public internet.**

---

## License

MIT License

---

## Author

**Simon Kofi Agyemang**

> DevSecOps Lab built for personal learning and practice.


