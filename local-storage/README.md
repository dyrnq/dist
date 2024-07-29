## local-storage

```bash
kubectl apply -f local-storage-sc.yaml


sed -i "s@__HOSTNAME_REPLACE__@name@g" local-storage-pod.yaml


mkdir -p /data/k8s/local/hostpath
echo "hello" >> /data/k8s/local/hostpath

kubectl apply -f local-storage-pod.yaml

kubectl exec -it pod/pv-hostpath-pod -c nginx -- bash -c "curl http://127.0.0.1"
curl $(kubectl get pod/pv-hostpath-pod -o jsonpath='{.status.podIP}')

```