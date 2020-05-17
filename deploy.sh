docker build -t rcollier1972/multi-client:latest -t rcollier1972/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rcollier1972/multi-server:latest -t rcollier1972/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rcollier1972/multi-worker:latest -t rcollier1972/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rcollier1972/multi-client:latest
docker push rcollier1972/multi-server:latest
docker push rcollier1972/multi-worker:latest
docker push rcollier1972/multi-client:$SHA
docker push rcollier1972/multi-server:$SHA
docker push rcollier1972/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rcollier1972/multi-server:$SHA
kubectl set image deployments/client-deployment client=rcollier1972/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rcollier1972/multi-worker:$SHA
