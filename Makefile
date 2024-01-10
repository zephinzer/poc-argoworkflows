CONTEXT := kind-poc-argoworkflows
NAMESPACE := argo

kind:
	@kind create cluster --config ./kind.config.yaml

unkind:
	@kind delete cluster --name poc-argoworkflows

use-kind:
	@kubectl config use-context $(CONTEXT)

port-forward:
	@$(MAKE) use-kind
	@kubectl port-forward --namespace argo svc/$$(kubectl get service --namespace argo | grep argo-workflows-server | tr -s '  ' ' ' | cut -f 1 -d ' ') 2746:2746

install:
	@$(MAKE) use-kind
	@cd ./deploy/charts/argo \
		&& helm upgrade --install \
			--create-namespace \
			--namespace $(NAMESPACE) \
			-f ./values.yaml \
			argo .

deploy-samples:
	@$(MAKE) use-kind
	@cd ./deploy/charts/argo-samples \
		&& helm upgrade --install \
			--create-namespace \
			--namespace $(NAMESPACE) \
			-f ./values.yaml \
			argo-samples .

get-client-token:
	@$(MAKE) use-kind
	@echo "Bearer $$(kubectl get secret -n argo argo-system-client -o=jsonpath='{.data.token}' | base64 --decode)"
