FROM registry.ci.openshift.org/openshift/release:golang-1.21 AS builder
WORKDIR /app/
COPY . .
RUN go build -mod vendor -o /tmp/controller ./cmd/controller

FROM openshift/origin-base
COPY --from=builder /tmp/controller /ko-app/controller
ENTRYPOINT ["/ko-app/controller"]
