#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"
set -e

source ./project.config.sh

SERVICE_NAME="deoetorbi-notificationpusher"
CLOUDRUN_TAG="gcr.io/${GCP_PROJECT_ID}/${SERVICE_NAME}"

gcloud config set project "${GCP_PROJECT_ID}"

gcloud builds submit --tag "${CLOUDRUN_TAG}"

gcloud beta run deploy "${SERVICE_NAME}" \
          --region "${GCP_REGION_CLOUDRUN}" \
          --image "${CLOUDRUN_TAG}" \
          --cpu 1 \
          --memory 128Mi \
          --max-instances 1 \
          --timeout 5s \
          --concurrency 1 \
          --no-allow-unauthenticated \
          --port 8080 \
          --platform managed

SERVICE_URL=$(gcloud run services describe ${SERVICE_NAME} --format 'value(status.url)' --platform managed --region=${GCP_REGION_CLOUDRUN})
SCHEDULER_SERVICE_ACCOUNT_EMAIL="deo-scheduler@deoetorbi.iam.gserviceaccount.com"
SCHEDULER_JOB="schedule-notifications-pusher-job"

gcloud scheduler jobs delete --quiet "${SCHEDULER_JOB}" || echo "Failed to delete scheduler job"
gcloud scheduler jobs create http ${SCHEDULER_JOB} --schedule "*/3 * * * *" \
   --http-method=GET \
   --uri="${SERVICE_URL}" \
   --oidc-service-account-email="${SCHEDULER_SERVICE_ACCOUNT_EMAIL}"   \
   --oidc-token-audience="${SERVICE_URL}"

echo "Done"