usage() {
    echo "Usage: [tag]" 
}

if [ ! $# -eq 1 ]
then 
    usage
    exit 0
fi

tag=$1

echo "Building docker container..."
docker build -t "emilkarlstrombth/movies_service_backend:${tag}" -t emilkarlstrombth/movies_service_backend:latest services/movies_service
docker build -t "emilkarlstrombth/movies_service_frontend:${tag}" -t "emilkarlstrombth/movies_service_frontend:latest" services/website/

echo "Pushing to docker hub..."
docker image push --all-tags "emilkarlstrombth/movies_service_backend"
docker image push --all-tags "emilkarlstrombth/movies_service_frontend"