.PHONY: kube-start
kube-start:
	minikube start --driver=docker

.PHONY: kube-list
kube-list:
	kubectl config get-clusters

.PHONY: kube-stop
kube-stop:
	minikube stop
