# Workload Identity Federation - to authenticate GCP using github actions

# Workload Identity Pool: Workload identity pools are used to organise and manage external identities. It is recommended to create a new pool for different non google cloud environments. Below command can be used to create the same:

# Workload Identity Provider: Workload Identity Provider describes the relationship between an external identity such as Github and Google Cloud. It basically establishes trust between external identity and GCP. It provides attribute mapping that applies the attributes from an external token to a Google token. This lets IAM use tokens from external providers to authorize access to Google Cloud resources. This is basically a way to translate external tokens into GCP equivalent tokens. Below command can be used to create the same:


# Workload-identity-pools
  gcloud iam workload-identity-pools create "pool" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --display-name="pool display name"

gcloud iam workload-identity-pools list --location global 


# workload-identity-provider
  gcloud iam workload-identity-pools providers create-oidc "provider-name" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool="pool" \
  --display-name="provider-display name" \
  --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository" \
  --issuer-uri="https://token.actions.githubusercontent.com"


gcloud iam workload-identity-pools providers list --location global --workload-identity-pool my-identity-pool-name

# 1.Create service account
gcloud iam service-accounts create test-wif \
--display-name="Service account used by WIF POC" \
--project <project_id>

# 2.add the respective policies to the service account based on the services you will use

# 3. Add IAM Policy bindings with Github repo, Identity provider and service account.
  gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT_EMAIL}" \
  --project="${GCP_PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/${GCP_PROJECT_NUMBER}/locations/global/workloadIdentityPools/k8s-pool/attribute.repository/${GITHUB_REPO}"

# 3.1There are options to restrict authentication from specific branches too. For that we need to use the principal like below.

principal://iam.googleapis.com/projects/cloudrun-flask/locations/global/workloadIdentityPools/my-identity-pool-name/subject/repo:user_name/repository_name:ref:refs/heads/main
# This ensures that only the main branch of repo user_name/repository_name can authenticate.

