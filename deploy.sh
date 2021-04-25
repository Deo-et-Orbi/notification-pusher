#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"
set -e

source ./project.config.sh

CONTAINER_NAME="deoetorbi_notificationpusher"
CLOUDRUN_TAG="gcr.io/${GCP_PROJECT_ID}/${CONTAINER_NAME}"

gcloud config set project "${GCP_PROJECT_ID}"

gcloud builds submit --tag "${CLOUDRUN_TAG}"

gcloud beta run deploy "${CONTAINER_NAME}" \
          --region "${GCP_REGION_CLOUDRUN}" \
          --image "${CLOUDRUN_TAG}" \
          --cpu 1 \
          --memory 128Mi \
          --min-instances 0 \
          --max-instances 1 \
          --timeout 5s \
          --concurrency 1 \
          --no-allow-unauthenticated \
          --port 8080 \
          --platform managed

