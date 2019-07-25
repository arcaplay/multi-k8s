docker build -t arcaplay/multi-client:latest -t arcaplay/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arcaplay/multi-server:latest -t arcaplay/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arcaplay/multi-worker:latest -t arcaplay/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push arcaplay/multi-client:latest
docker push arcaplay/multi-server:latest
docker push arcaplay/multi-worker:latest

docker push arcaplay/multi-client:$SHA
docker push arcaplay/multi-server:$SHA
docker push arcaplay/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arcaplay/multi-server:$SHA
kubectl set image deployments/client-deployment client=arcaplay/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arcaplay/multi-worker:$SHA