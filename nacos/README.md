# nacos on k8s

## deploy nacos

```bash
kubectl apply -f ./2.1.2/10-deployments.yaml
```

```bash
kubectl get sts,svc,pod,ep,cm -n nacos-system -o wide
```

## login nacos

> nodeport url

```bash
http://node-ip:30888/nacos
```

> nacos default user and password

```bash
nacos
nacos
```

## ref

- [nacos-k8s/tree/master/helm](https://github.com/nacos-group/nacos-k8s/tree/master/helm)
