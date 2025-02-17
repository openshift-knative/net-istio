generate-release:
	./openshift/generate.sh
	./hack/update-deps.sh
.PHONY: generate-release
