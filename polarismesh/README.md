# polaris on k8s

## deploy polaris

```bash
kubectl apply -f ./v1.12.1/10-deployments.yaml
```

```bash
kubectl get sts,svc,pod,ep -o wide -n polaris-system
```

## login polaris

> nodeport url

```bash
http://node-ip:node-port
```

> polaris default user and password

```bash
polaris
polaris
```

## ref

- [https://polarismesh.cn/](https://polarismesh.cn/)
- [https://github.com/polarismesh/polaris](https://github.com/polarismesh/polaris)
