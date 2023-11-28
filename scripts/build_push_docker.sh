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
docker build -t emilkarlstrombth/movies_service_backend:$tag services/movies_service

echo "Pushing to docker hub..."
docker push emilkarlstrombth/movies_service_backend:$tag