.PHONY: kube-start
kube-start:
	minikube start --driver=docker

.PHONY: kube-list
kube-list:
	kubectl config get-clusters

.PHONY: kube-stop
kube-stop:
	minikube stop

.PHONY: argocd-install-namespace
argocd-install-namespace: 
	- kubectl create namespace argocd

.PHONY: argocd-install
argocd-install: argocd-install-namespace
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

.PHONY: argocd-network-lb
argocd-network-lb:
	kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

.PHONY: argocd-network
argocd-network: argocd-network-lb
	kubectl port-forward svc/argocd-server -n argocd 8080:443
