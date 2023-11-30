if [[ $# -eq 1 ]]
then
    if [[ $1 = "drop" ]]
    then
        kubectl exec --stdin --tty service/movies-api-balancer -- mix ecto.drop
    fi
fi

kubectl exec --stdin --tty service/movies-api-balancer -- bash -c "mix ecto.create && mix ecto.migrate"

echo "Starting forward process: $PID"
./scripts/manage.sh forward k b > /dev/null &
PID=$!

sleep 1
echo "Populating database..."
python ./scripts/_populate_db.py

printf "Stopping forwarding..."
ps -ef | grep 'kubectl port-forward service/movies-api-balancer' | grep -v grep | awk '{print $2}' | xargs kill
echo "Complete"