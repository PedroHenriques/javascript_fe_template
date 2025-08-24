#!/bin/bash
set -euo pipefail;

: "${BASE_URL:=/}";
: "${SRC_DIR:=src}";

USE_DOCKER=0;
RUNNING_IN_PIPELINE=0;
BASE_PER_SERVICE=0;
SERVICES=();

while [ "$#" -gt 0 ]; do
  case "$1" in
    --docker) USE_DOCKER=1; shift ;;
    --cicd) RUNNING_IN_PIPELINE=1; USE_DOCKER=1; shift ;;
    --base-per-service) BASE_PER_SERVICE=1; shift ;;

    -*) echo "unknown option: $1" >&2; exit 1 ;;
    *) SERVICES+=("$1"); shift ;;
  esac
done

if ((${#SERVICES[@]}==0)); then
  mapfile -t SERVICES < <(find "${SRC_DIR}" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort);
fi

for service in "${SERVICES[@]}"; do
  echo "▶ Building: ${service}";

  if [ $BASE_PER_SERVICE -eq 1 ]; then
    export BASE_URL="/${service}/";
  else
    export BASE_URL="${BASE_URL}";
  fi

  export SERVICE="${service}";

  rm -rf "./dist/${service}";

  npm run build:prod;
done
