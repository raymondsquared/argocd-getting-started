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

2. **Configure ArgoCD**:

   - By default, the Argo CD API server is not exposed with an external IP. To access the API server, choose one of the following techniques to expose the Argo CD API server:

   - Change the argocd-server service type to LoadBalancer:

     ```sh
     make argocd-network
     ```

     or

     ```sh
     kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
     ```

   - Kubectl port-forwarding can also be used to connect to the API server without exposing the service.

     ```sh
     make argocd-network
     ```

     or

     ```shsh
     kubectl port-forward svc/argocd-server -n argocd 8080:443
     ```

   - You can then access the API server at https://localhost:8080.

   - The initial password for the admin account is auto-generated and stored as clear text in the field password in a secret named argocd-initial-admin-secret in your Argo CD installation namespace. You can simply retrieve this password using the argocd CLI:

     ```sh
     argocd admin initial-password -n argocd
     ```

     or

     ```sh
     kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
     ```

   - Using the username admin and the password from above, login to Argo CD's IP or hostname:

     ```sh
     argocd login localhost:8080
     ```

3. Register A Cluster To Deploy Apps To (Optional)

   - List all clusters contexts in your current kubeconfig:

     ```sh
     kubectl config get-contexts -o name
     ```

   - Supply it to argocd cluster add CONTEXTNAME. For example, for docker-desktop context, run:
     ```sh
     argocd cluster add minikube
     ```

4. Create An Application From A Git Repository

   - First we need to set the current namespace to argocd running the following command:

     ```sh
     kubectl config set-context --current --namespace=argocd
     ```

    - Create a namespace for applications

     ```sh
     kubectl create namespace ray-application
     ```

   - Create the example guestbook application with the following command:

     ```sh
     argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace ray-application
     ```

   - Once the guestbook application is created, you can now view its status:

     ```sh
     argocd app get guestbook
     ```

   - To sync (deploy) the application, run:

     ```sh
     argocd app sync guestbook
     ```

   - To configure automated sync run (optional):

     ```sh
     argocd app set guestbook --sync-policy automated
     ```
