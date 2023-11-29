# COLORS
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m'    # no color

# Deletes all the K8 resources 
deleteKubernetesResources() {
    printf "${GREEN}Deleting all Kubernetes resouces${NC}\n"
    objsToDrop=("services" "deployments" "configmaps")

    for obj in ${objsToDrop[@]}
    do
        printf "${ORANGE}Deleting $obj ${NC}\n"
        kubectl delete $obj --all 1> /dev/null
    done

    printf "${CYAN}Deleting PresistentVolumeClaims...${NC}\n"
    kubectl patch pvc postgres-pv-claim -p '{"metadata":{"finalizers":null}}' 1> /dev/null
    kubectl delete pvc postgres-pv-claim --grace-period=0 --force 1> /dev/null

    printf "${CYAN}Deleting PresistentVolumes...${NC}\n"
    kubectl patch pv postgres-pv-volume -p '{"metadata":{"finalizers":null}}' 1> /dev/null
    kubectl delete pv postgres-pv-volume --grace-period=0 --force 1> /dev/null

    printf "${GREEN}Done${NC}\n"
}

# Deploys all the K8 resources
deployKubernetesResources() 
{
    # Set up postgres first and foremost
    printf "${BLUE}Deploying postgres...${NC}\n"
    kubectl apply -f postgres-config.yaml    
    kubectl apply -f postgres-pvc-pv.yaml   
    kubectl apply -f postgres-service.yaml   
    kubectl apply -f postgres-deployment.yaml
    # Read the database ip
    POSTGRES_IP=$(kubectl get service/postgres-service -o jsonpath='{.spec.clusterIP}')
    printf "${BLUE}Postgres deployed. Binding postgres ip ($POSTGRES_IP) to configuration${NC}\n"

    # Apply the database ip to the movie-service config
    # it's not great but it works for now :D 
    # Totally not stolen from the course so that's cool
    kubectl apply -f movies-config.yaml 2> /dev/null 
    kubectl get configmap/movies-service-config -o yaml \
        | sed -r "s/NOTSET/$POSTGRES_IP/" | kubectl apply -f - 

    # Deploy movies-service and load balancer
    printf "${BLUE}Deploying movies-service...${NC}\n"
    kubectl apply -f movies-deployment.yaml 
}

# A short function that checks the second argument when invoked with "deploy"
# to see if we want forward the services with minikube or kubectl, or not at all
deployWith() 
{
    case $1 in
        "minikube" | "mk")
            if command -v minikube &> /dev/null
            then 
                printf "${BLUE}Found minikube installation, creating minikube url connection${NC}\n"
                minikube service movies-service-balancer --url
            else
                printf "${RED}Could not find command \"minikube\"${NC}\n"
            fi
            ;;
        "kubectl" | "k")
            kubectl port-forward service/movies-service-balancer 4000:4000
            ;;
    esac
}

usage() 
{
    printf "Usage:\n"
}



#############################
#### PROGRAM STARTS HERE ####
#############################

if [[ $# -eq 0 ]] 
then
    usage
    exit 0
fi

case $1 in
    "delete")
        deleteKubernetesResources
        ;;
    "deploy")
        deployKubernetesResources
        ;;
    "forward")
        deployWith $2
esac