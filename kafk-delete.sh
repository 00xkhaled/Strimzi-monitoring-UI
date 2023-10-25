#minikube start --memory=4096

kubectl delete namespace kafka

kubectl delete -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka

kubectl delete -f kafka.yaml -n kafka

kubectl delete -f kafka-topic.yaml -n kafka

kubectl delete namespace monitoring

kubectl delete -f prometheus-operator-deployment.yaml -n monitoring --force-conflicts=true --server-side


kubectl delete -f kafka-metrics-config.yaml -n kafka

kubectl delete -f zookeeper-metrics.yaml -n kafka

kubectl delete -f kafka.yaml -n kafka

kubectl delete -f prometheus.yaml -n monitoring

kubectl delete -f strimzi-pod-monitor.yaml -n monitoring

kubectl delete -f grafana/grafana.yaml -n monitoring

