# csi-s3

## deploy

```bash

s3_endpoint="http://192.168.1.119:9000"
s3_access_key="foo"
s3_secret_key="bar"

cat < 0.40.6/10-deployments.yaml \
| sed "s@__S3_ENDPOINT__@$s3_endpoint@g" \
| sed "s@__S3_ACCESS_KEY__@$s3_access_key@g" \
| sed "s@__S3_SECRET_KEY__@$s3_secret_key@g" \
| kubectl apply -f -


cat <<EOF | kubectl apply -f -
# Source: csi-s3/templates/storageclass.yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: csi-s3
provisioner: ru.yandex.s3.csi
parameters:
  mounter: "geesefs"
  options: "--memory-limit 1000 --dir-mode 0777 --file-mode 0666"
  csi.storage.k8s.io/provisioner-secret-name: csi-s3-secret
  csi.storage.k8s.io/provisioner-secret-namespace: kube-system
  csi.storage.k8s.io/controller-publish-secret-name: csi-s3-secret
  csi.storage.k8s.io/controller-publish-secret-namespace: kube-system
  csi.storage.k8s.io/node-stage-secret-name: csi-s3-secret
  csi.storage.k8s.io/node-stage-secret-namespace: kube-system
  csi.storage.k8s.io/node-publish-secret-name: csi-s3-secret
  csi.storage.k8s.io/node-publish-secret-namespace: kube-system
reclaimPolicy: Delete
EOF


cat <<EOF | kubectl apply -f -
# https://github.com/yandex-cloud/k8s-csi-s3/blob/master/deploy/kubernetes/examples/pvc.yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: csi-s3-pvc
  namespace: default
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 5Gi
  storageClassName: csi-s3
# https://github.com/yandex-cloud/k8s-csi-s3/blob/master/deploy/kubernetes/examples/pod.yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: csi-s3-test-nginx
  namespace: default
spec:
  containers:
   - name: csi-s3-test-nginx
     image: nginx
     volumeMounts:
       - mountPath: /usr/share/nginx/html/s3
         name: webroot
     #livenessProbe:
     startupProbe:
       exec:
         command:
         - ls
         - /usr/share/nginx/html/s3
       initialDelaySeconds: 2
       periodSeconds: 2
       successThreshold: 1
       failureThreshold: 1
       terminationGracePeriodSeconds: 2
  volumes:
   - name: webroot
     persistentVolumeClaim:
       claimName: csi-s3-pvc
       readOnly: false
EOF

kubectl exec -it pod/csi-s3-test-nginx -- bash -c "echo hello >> /usr/share/nginx/html/s3/index.html"
kubectl exec -it pod/csi-s3-test-nginx -- bash -c "curl http://127.0.0.1/s3/index.html"
kubectl delete pod csi-s3-test-nginx
```
