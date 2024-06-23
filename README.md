# argocd-getting-started

## Prerequisites

### Kubernetes

1. **Install Docker**:
   Ensure Docker is installed on your system:

   ```sh
   brew install docker
   ```

2. **Install Kubernetes**:
   If you prefer to use a local k8s, install `minikube` and start it by running:
   ```sh
   make kube-start
   ```

## Usage

1. **Install ArgoCD**:

   - Download Argo CD CLI on your machine:

     ```sh
     brew install argocd
     ```

   - Install Argo CD on your Kubernetes cluster:

     ```sh
     make argocd-install
     ```

