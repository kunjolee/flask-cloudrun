#list services account
gcloud iam service-accounts list --project=<project_id>

# create service account
gcloud iam service-accounts create "name" \
--display-name="Service account used by name" \
--project <project_id>

# create key.json from identifier@<project_id>.iam.gserviceaccount.com
gcloud iam service-accounts keys create ./my-service-account.json --iam-account identifier@<project_id>.iam.gserviceaccount.com

# set the service account as the account locally
gcloud auth activate-service-account identifier@<project_id>.iam.gserviceaccount.com --key-file=key.json

# set role
gcloud projects add-iam-policy-binding <project_id> \
--member='serviceAccount:test-wif@<project_id>.iam.gserviceaccount.com' \
--role="roles/compute.viewer"