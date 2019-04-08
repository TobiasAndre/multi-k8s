docker build -t tobiasandre/multi-client:latest -t tobiasandre/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tobiasandre/multi-server:latest -t tobiasandre/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tobiasandre/multi-worker:latest -t tobiasandre/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tobiasandre/multi-client:latest
docker push tobiasandre/multi-server:latest
docker push tobiasandre/multi-worker:latest

docker push tobiasandre/multi-client:$SHA
docker push tobiasandre/multi-server:$SHA
docker push tobiasandre/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tobiasandre/multi-server:$SHA
kubectl set image deployments/client-deployment client=tobiasandre/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tobiasandre/multi-worker:$SHA
