# build docker image
docker build -t cloudrun-image-test:latest .        
# run container
PORT=8080 && docker run -p 9090:${PORT} -e PORT=${PORT} cloudrun-image-test:latest

# create artifact registry repository
gcloud artifacts repositories create repository-name --repository-format=docker \
    --location=location --description="Docker cloud run repository"

    # https://cloud.google.com/sdk/release_notes
# LOCATION-docker.pkg.dev/<project_id>/REPOSITORY/IMAGE


# build to cs and artifact registry
gcloud builds submit --region=location --tag location-docker.pkg.dev/<project_id>/repository-name/image:latest


# deploy cloud run
gcloud run deploy my-flask-app --image location-docker.pkg.dev/<project_id>/repository-name/image:latest --platform managed --project=<project_id> --allow-unauthenticated --region location