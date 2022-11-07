# apisix

## create namespace

```bash
kubectl apply -f 2.15.0/00-namespace.yaml
```

## deploy etd(sts)

```bash
kubectl apply -f 2.15.0/10-deployments-etcd.yaml
```

## deploy apisix and apisix-dashboard.yaml

```bash
kubectl apply -f 2.15.0/10-deployments-apisix.yaml
kubectl apply -f 2.15.0/10-deployments-apisix-dashboard.yaml
```

## dashboard default user and password

```bash
username: admin
password: admin
```
