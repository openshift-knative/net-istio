FROM registry.ci.openshift.org/openshift/release:rhel-8-release-golang-1.22-openshift-4.17 AS builder
WORKDIR /app/
COPY . .
RUN go build -mod vendor -o /tmp/webhook ./cmd/webhook

FROM openshift/origin-base
COPY --from=builder /tmp/webhook /ko-app/webhook
ENTRYPOINT ["/ko-app/webhook"]
