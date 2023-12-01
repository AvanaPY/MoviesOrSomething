usage() {
    echo "Usage: [tag]" 
}

if [ $# -eq 0 ]
then 
    usage
    exit 0
fi

tag=$1

echo "Building docker container..."
docker build -t "emilkarlstrombth/movies_service_backend:${tag}" -t emilkarlstrombth/movies_service_backend:latest services/movies_service
docker build -t "emilkarlstrombth/movies_service_frontend:${tag}" -t "emilkarlstrombth/movies_service_frontend:latest" services/website/

echo "Pushing to docker hub..."
docker image push "emilkarlstrombth/movies_service_backend:${tag}"
docker image push "emilkarlstrombth/movies_service_frontend:${tag}"

if [ $# -eq 2 ] 
then
    case $2 in
        "latest")
            print "Pushing latest..."
            docker image push "emilkarlstrombth/movies_service_backend:latest"
            docker image push "emilkarlstrombth/movies_service_frontend:latest"
            ;;
    esac
fi