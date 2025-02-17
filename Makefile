generate-release:
	./hack/update-codegen.sh
	./openshift/generate.sh
.PHONY: generate-release
