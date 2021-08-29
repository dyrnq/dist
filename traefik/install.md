# traefik-ingress-controller

## install crd

```bash
#!/usr/bin/env bash
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/traefik/traefik/v2.5/docs/content/reference/dynamic-configuration/traefik.containo.us_ingressroutes.yaml
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/traefik/traefik/v2.5/docs/content/reference/dynamic-configuration/traefik.containo.us_ingressroutetcps.yaml
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/traefik/traefik/v2.5/docs/content/reference/dynamic-configuration/traefik.containo.us_ingressrouteudps.yaml
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/traefik/traefik/v2.5/docs/content/reference/dynamic-configuration/traefik.containo.us_middlewares.yaml
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/traefik/traefik/v2.5/docs/content/reference/dynamic-configuration/traefik.containo.us_middlewaretcps.yaml
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/traefik/traefik/v2.5/docs/content/reference/dynamic-configuration/traefik.containo.us_serverstransports.yaml
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/traefik/traefik/v2.5/docs/content/reference/dynamic-configuration/traefik.containo.us_tlsoptions.yaml
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/traefik/traefik/v2.5/docs/content/reference/dynamic-configuration/traefik.containo.us_tlsstores.yaml
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/traefik/traefik/v2.5/docs/content/reference/dynamic-configuration/traefik.containo.us_traefikservices.yaml

```

## install deploy.yaml

```bash
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/dyrnq/dist/main/traefik/yaml/deploy.yaml
```

## kubectl get all

```bash
kubectl get all,cm,sa -n traefik-io -o wide
```

## uninstall

```bash
kubectl delete -f https://ghproxy.com/https://raw.githubusercontent.com/dyrnq/dist/main/traefik/yaml/deploy.yaml
```
