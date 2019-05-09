echo "DINESH_KUMAR BUILDING docker images for multi-client"
docker build -t dineshtailor/multi-client:latest -t dineshtailor/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dineshtailor/multi-server:latest -t dineshtailor/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dineshtailor/multi-worker:latest -t dineshtailor/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dineshtailor/multi-client:latest
docker push dineshtailor/multi-server:latest
docker push dineshtailor/multi-worker:latest

docker push dineshtailor/multi-client:$SHA
docker push dineshtailor/multi-server:$SHA
docker push dineshtailor/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dineshtailor/multi-server:$SHA
kubectl set image deployments/client-deployment client=dineshtailor/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dineshtailor/multi-worker:$SHA
