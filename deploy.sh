docker build -t dockercristina/multi-client:latest -t dockercristina/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dockercristina/multi-server:latest -t dockercristina/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dockercristina/multi-worker:latest -t dockercristina/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dockercristina/multi-client:latest
docker push dockercristina/multi-server:latest
docker push dockercristina/multi-worker:latest

docker push dockercristina/multi-client:$SHA
docker push dockercristina/multi-server:$SHA
docker push dockercristina/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dockercristina/multi-server:$SHA
kubectl set image deployments/client-deployment client=dockercristina/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dockercristina/multi-worker:$SHA