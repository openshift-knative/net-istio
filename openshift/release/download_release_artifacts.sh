#!/usr/bin/env bash

# Usage example: ./download_release_artifacts.sh v1.3.0

set -Eeuo pipefail

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

patches_path="${SCRIPT_DIR}/../patches"
artifacts_path="${SCRIPT_DIR}/artifacts"
mkdir -p "${patches_path}"
mkdir -p "${artifacts_path}"
# These files could in theory change from release to release, though their names should
# be fairly stable.
istio_files=(200-clusterrole 400-config-istio 500-controller 500-webhook-deployment 500-webhook-secret 500-webhook-service 600-mutating-webhook 600-validating-webhook)

function download_ingress {
  component=$1
  version=$2
  shift
  shift

  files=("$@")

  component_dir="${artifacts_path}"
  release_suffix="${version%?}0"
  target_dir="${component_dir}"
  rm -r "$component_dir"
  mkdir -p "$target_dir"

  for (( i=0; i<${#files[@]}; i++ ));
  do
    index=$(( i+1 ))
    file="${files[$i]}.yaml"
    target_file="$target_dir/$index-$file"

    url="https://raw.githubusercontent.com/knative-sandbox/${component}/knative-${version}/config/${file}"
    wget --no-check-certificate "$url" -O "$target_file"
  done
}

download_ingress net-istio "$1" "${istio_files[@]}"

# Add networkpolicy for webhook when net-istio is enabled.
git apply "${patches_path}/001-networkpolicy-mesh.patch"
