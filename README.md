# OpenShift net-istio

This repository holds OpenShift's fork of
[`knative/net-istio`](https://github.com/knative-sandbox/net-istio) with additions and
fixes needed only for the OpenShift side of things.

# OpenShift net-istio Release procedure

Currently the release cut is not automated but just one command.
Once upstream cuts the branch (e.g. upstream cut `release-1.9` branch), just run:

```sh
$ openshift/release/create-release-branch.sh release-1.9
```

Then, push the branch against to this repository.
