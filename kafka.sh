#minikube start --memory=4096

kubectl create namespace kafka

kubectl config set-context --current --namespace=kafka
sleep 10

kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka
sleep 10

kubectl apply -f kafka.yaml -n kafka
sleep 10

kubectl apply -f kafka-topic.yaml -n kafka
sleep 10

kubectl create namespace monitoring
sleep 10

kubectl apply -f prometheus-operator-deployment.yaml -n monitoring --force-conflicts=true --server-side
sleep 10

kubectl apply -f kafka-metrics-config.yaml -n kafka
sleep 10

kubectl apply -f zookeeper-metrics.yaml -n kafka
sleep 10

kubectl apply -f kafka.yaml -n kafka
sleep 10

kubectl apply -f prometheus.yaml -n monitoring
sleep 10

kubectl apply -f strimzi-pod-monitor.yaml -n monitoring
sleep 10

kubectl apply -f grafana/grafana.yaml -n monitoring
sleep 10

kubectl port-forward svc/grafana 3000:3000 -n monitoring & 
kubectl port-forward svc/prometheus-operated 9090:9090 -n monitoring &

NS=`kubectl get ns |grep Terminating | awk 'NR==1 {print $1}'` && kubectl get namespace "$NS" -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/$NS/finalize -f -