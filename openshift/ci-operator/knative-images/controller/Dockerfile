FROM registry.ci.openshift.org/openshift/release:rhel-8-release-golang-1.22-openshift-4.17 AS builder
WORKDIR /app/
COPY . .
RUN go build -mod vendor -o /tmp/controller ./cmd/controller

FROM openshift/origin-base
COPY --from=builder /tmp/controller /ko-app/controller
ENTRYPOINT ["/ko-app/controller"]
