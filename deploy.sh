docker build -t vipersl/multi-client:latest -t vipersl/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vipersl/multi-server:latest -t vipersl/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vipersl/multi-worker:latest -t vipersl/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vipersl/multi-client:latest
docker push vipersl/multi-server:latest
docker push vipersl/multi-worker:latest

docker push vipersl/multi-client:$SHA
docker push vipersl/multi-server:$SHA
docker push vipersl/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=vipersl/multi-server:$SHA
kubectl set image deployments/client-deployments client=vipersl/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=vipersl/multi-worker:$SHA
