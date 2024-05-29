docker build -t kamalpanhwar/multi-client:latest -t kamalpanhwar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kamalpanhwar/multi-server:latest -t kamalpanhwar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kamalpanhwar/multi-worker:latest -t kamalpanhwar/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kamalpanhwar/multi-client:latest
docker push kamalpanhwar/multi-client:$SHA
docker push kamalpanhwar/multi-server:latest
docker push kamalpanhwar/multi-server:$SHA
docker push kamalpanhwar/multi-worker:latest
docker push kamalpanhwar/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kamalpanhwar/multi-server:$SHA
kubectl set image deployments/client-deployment server=kamalpanhwar/multi-client:$SHA
kubectl set image deployments/worker-deployment server=kamalpanhwar/multi-worker:$SHA
