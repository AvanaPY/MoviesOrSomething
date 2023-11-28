kubectl exec --stdin --tty service/movies-service-balancer -- mix ecto.create
kubectl exec --stdin --tty service/movies-service-balancer -- mix ecto.migrate