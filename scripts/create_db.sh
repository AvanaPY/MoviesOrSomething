

if [[ $# -eq 1 ]]
then
    if [[ $1 = "drop" ]]
    then
        kubectl exec --stdin --tty service/movies-api-balancer -- mix ecto.drop
    fi
fi

kubectl exec --stdin --tty service/movies-api-balancer -- bash -c "mix ecto.create && mix ecto.migrate"