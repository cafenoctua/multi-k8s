docker build -t brubian/multi-client:latest -t brubian/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brubian/multi-server:latest -t brubian/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brubian/multi-worker:latest -t brubian/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push brubian/multi-client:latest
docker push brubian/multi-server:latest
docker push brubian/multi-worker:latest

docker push brubian/multi-client:$SHA
docker push brubian/multi-server:$SHA
docker push brubian/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=brubian/multi-server:$SHA
kubectl set image deployments/client-deployment client=brubian/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=brubian/multi-worker:$SHA