#!/usr/bin/env bash

# Usage example: ./download_release_artifacts.sh 1.8.0

set -Eeuo pipefail

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

# TODO: automatically detects the version via branch name or something.
VERSION=$1

function resolve_resources(){
  local dir=$1
  local resolved_file_name=$2

  # Exclude Istio resources that are deployed by users.
  local exclude_option="-not -name 202-gateway.yaml \
			-not -name 203-local-gateway.yaml \
			-not -name 400-webhook-peer-authentication.yaml"

  echo "Writing resolved yaml to $resolved_file_name"

  > "$resolved_file_name"

  for yaml in `find $dir -type f $exclude_option -name "*.yaml" | sort`; do
    resolve_file "$yaml" "$resolved_file_name"
  done
}

function resolve_file() {
  local file=$1
  local to=$2

  echo "---" >> "$to"

  echo $file

  sed -e "s+app.kubernetes.io/version: devel+app.kubernetes.io/version: \""$VERSION"\"+" \
      "$file" >> "$to"

}

readonly YAML_OUTPUT_DIR="openshift/release/artifacts/"
readonly NETWORK_POLICY_YAML=${YAML_OUTPUT_DIR}/0-networkpolicy-mesh.yaml
readonly NET_ISTIO_YAML=${YAML_OUTPUT_DIR}/1-net-istio.yaml

# Clean up
rm -rf "$YAML_OUTPUT_DIR"
mkdir -p "$YAML_OUTPUT_DIR"

patches_path="${SCRIPT_DIR}/../patches"

git apply "${patches_path}"/*

resolve_resources "config/" "$NET_ISTIO_YAML"
resolve_resources "openshift/release/extra/" "$NETWORK_POLICY_YAML"
