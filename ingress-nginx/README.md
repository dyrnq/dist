# ingress-nginx

## install

```bash
ver="4.1.4"
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/dyrnq/dist/main/ingress-nginx/${ver}/00-namespace.yaml

kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/dyrnq/dist/main/ingress-nginx/${ver}/10-deployments.yaml
```

```bash
kubectl -n ingress-nginx get all -o wide
```

## upgrade
```bash
ver="4.1.4"
kubectl -n ingress-nginx delete job ingress-nginx-admission-create ingress-nginx-admission-patch
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/dyrnq/dist/main/ingress-nginx/${ver}/10-deployments.yaml
```

```bash
kubectl -n ingress-nginx get all -o wide
```

## options deployment or daemonset

### deployments-->daemonset
```bash
ver="4.1.4"
kubectl -n ingress-nginx delete job ingress-nginx-admission-create ingress-nginx-admission-patch
kubectl -n ingress-nginx delete deployments ingress-nginx-controller
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/dyrnq/dist/main/ingress-nginx/${ver}/10-daemonset.yaml
```

### daemonset-->deployments
```bash
ver="4.1.4"
kubectl -n ingress-nginx delete job ingress-nginx-admission-create ingress-nginx-admission-patch
kubectl -n ingress-nginx delete daemonset ingress-nginx-controller
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/dyrnq/dist/main/ingress-nginx/${ver}/10-deployments.yaml
```



## test

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: thor
---
kind: Deployment
apiVersion: apps/v1
metadata:
  namespace: thor
  name: whoami
  labels:
    app.kubernetes.io/name: whoami
    app.kubernetes.io/instance: release
spec:
  replicas: 2
  selector:
    matchLabels:
      app.kubernetes.io/name: whoami
      app.kubernetes.io/instance: release
  template:
    metadata:
      labels:
        app.kubernetes.io/name: whoami
        app.kubernetes.io/instance: release
    spec:
      containers:
        - name: whoami
          image: containous/whoami:latest
          imagePullPolicy: IfNotPresent
          ports:
            - name: http 
              containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  namespace: thor
  name: whoami
  labels:
    app.kubernetes.io/name: whoami
    app.kubernetes.io/instance: release
spec:
  ports:
    - name: http
      port: 80
  selector:
    app.kubernetes.io/name: whoami
    app.kubernetes.io/instance: release
EOF

if kubectl explain ingress --api-version="extensions/v1beta1" >/dev/null 2>&1; then
cat <<EOF | kubectl apply -f -
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  namespace: thor
  name: myingress
  labels:
    app.kubernetes.io/name: whoami
    app.kubernetes.io/instance: release
  annotations:
    nginx.ingress.kubernetes.io/use-regex: "true"
    kubernetes.io/ingress.class: nginx
spec:
  rules:
  - host: whoami.thor.io
    http:
      paths:
      - backend:
          serviceName: whoami
          servicePort: 80
EOF
fi

if kubectl explain ingress --api-version="networking.k8s.io/v1beta1" >/dev/null 2>&1; then
cat <<EOF | kubectl apply -f -
---
kind: Ingress
apiVersion: networking.k8s.io/v1beta1
metadata:
  namespace: thor
  name: myingress
  labels:
    app.kubernetes.io/name: whoami
    app.kubernetes.io/instance: release
  annotations:
    nginx.ingress.kubernetes.io/use-regex: "true"
    kubernetes.io/ingress.class: nginx
spec:
  rules:
  - host: whoami.thor.io
    http:
      paths:
      - backend:
          serviceName: whoami
          servicePort: 80
EOF
fi

if kubectl explain ingress --api-version="networking.k8s.io/v1" >/dev/null 2>&1; then
cat <<EOF | kubectl apply -f -
---
kind: Ingress
apiVersion: networking.k8s.io/v1
metadata:
  namespace: thor
  name: myingress
  labels:
    app.kubernetes.io/name: whoami
    app.kubernetes.io/instance: release
spec:
  ingressClassName: nginx
  rules:
    - host: whoami.thor.io
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: whoami
                port:
                  number: 80
EOF
fi


curl -H "host:whoami.thor.io" http://$(kubectl get svc -n ingress-nginx -l app.kubernetes.io/component=controller -o jsonpath='{.items[0].spec.clusterIP}')
```

## ref

* <https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx>
* <https://github.com/kubernetes/ingress-nginx>
* <https://kubernetes.github.io/ingress-nginx/>
