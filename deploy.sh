docker pull stella3/multi-client:latest
docker pull stella3/multi-api:latest
docker pull stella3/multi-worker:latest
docker build --cache-from stella3/multi-client -t stella3/multi-client:latest -f ./client/Dockerfile ./client
docker build --cache-from stella3/multi-api -t stella3/multi-api:latest -f ./server/Dockerfile ./server
docker build --cache-from stella3/multi-worker -t stella3/multi-worker:latest -f ./worker/Dockerfile ./worker
docker tag stella3/multi-client:latest stella3/multi-client:$SHA
docker tag stella3/multi-api:latest stella3/multi-api:$SHA
docker tag stella3/multi-worker:latest stella3/multi-worker:$SHA
docker push stella3/multi-client:latest
docker push stella3/multi-api:latest
docker push stella3/multi-worker:latest
docker push stella3/multi-client:$SHA
docker push stella3/multi-api:$SHA
docker push stella3/multi-worker:$SHA
kubectl apply -f deployments
kubectl set image deployments/api-deployment api=stella3/multi-api:$SHA --record 
kubectl set image deployments/client-deployment client=stella3/multi-client:$SHA --record 
kubectl set image deployments/worker-deployment worker=stella3/multi-worker:$SHA --record