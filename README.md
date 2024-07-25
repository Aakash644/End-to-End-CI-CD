# End-to-End CI/CD Project

## Table of Contents

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Setup and Installation](#setup-and-installation)
    - AWS EKS Cluster
    - GitHub Actions
    - Docker
    - Helm
    - ArgoCD
    - Kubernetes
4. [CI/CD Pipeline Workflow](#cicd-pipeline-workflow)
5. [Usage](#usage)
6. [Contributing](#contributing)
7. [License](#license)

## Introduction

This repository demonstrates an end-to-end CI/CD pipeline using AWS Elastic Kubernetes Service (EKS), GitHub Actions, Docker, Helm, ArgoCD, and Kubernetes. The pipeline automates the process of building, testing, and deploying applications to an EKS cluster.

## Prerequisites

- AWS account with permissions to create EKS clusters
- GitHub account
- Docker installed locally
- Helm installed locally
- Kubectl installed locally
- ArgoCD installed and configured
- Eksctl installed locally

## Setup and Installation

### AWS EKS Cluster

1. **Create EKS Cluster**:
    ```bash
    eksctl create cluster --name <cluster-name> --region <region>
    ```

### GitHub Actions

1. **Create a GitHub Repository** and clone it to your local machine.
2. **Add GitHub Actions Workflow**:

### Docker

1. **Create Dockerfile**:
```Dockerfile
   #start with a base image
FROM golang:1.22 as base

#setup work dir inside container
WORKDIR /app

#copy go mod files
COPY go.mod ./ 

# Download all the dependencies
RUN go mod download

#copying source code to work dir
COPY . .

# Build the application
RUN go build -o main .

#################################################

FROM gcr.io/distroless/base

# Copy the binary from the previous stage
COPY --from=base /app/main .

# Copy the static files from the previous stage
COPY --from=base /app/static ./static


# Expose the port on which the application will run
EXPOSE 8080

# Command to run the application
CMD ["./main"]  
```
    
## CI/CD Pipeline Workflow

1. **Code Push**: Developer pushes code to the GitHub repository.
2. **Build and Test**: GitHub Actions build the Docker image and run tests.
3. **Docker Image**: Docker image is pushed to Docker Hub.
4. **Helm chart**: docker image tag is updated in helm chart in this repo.
5. **Deploy**: ArgoCD pulls the latest Docker image and deploys it to the EKS cluster using Helm.

## Usage

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/user/repo.git
    cd repo
    ```

2. **Configure Kubernetes Context**:
    ```bash
    aws eks --region us-west-2 update-kubeconfig --name my-cluster
    ```

3. **Deploy Application**:
    ```bash
    helm install my-app ./my-chart
    ```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to customize this README further based on your specific project details and requirements.
