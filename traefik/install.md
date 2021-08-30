# traefik-ingress-controller

## install crd

```bash
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

[ref](https://github.com/traefik/traefik/tree/master/docs/content/reference/dynamic-configuration)

## install deploy.yaml

```bash
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/dyrnq/dist/main/traefik/yaml/deploy.yaml
```

## kubectl get all

```bash
kubectl get all,cm,sa -n traefik-io -o wide
```

## install ingress demo

```bash
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/dyrnq/dist/main/traefik/yaml/ing.yaml
```

```bash
curl -D- --header "host:foo.io"  http://$(kubectl get svc traefik-ingress-controller -n traefik-io -o jsonpath='{.spec.clusterIP}')


HTTP/1.1 200 OK
Content-Length: 387
Content-Type: text/plain; charset=utf-8
Date: Mon, 30 Aug 2021 01:06:24 GMT

Hostname: whoami-764856985-srtwl
IP: 127.0.0.1
IP: 10.244.235.177
RemoteAddr: 10.244.182.57:54432
GET / HTTP/1.1
Host: foo.io
User-Agent: curl/7.68.0
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 10.244.137.64
X-Forwarded-Host: foo.io
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: traefik-ingress-controller-7cc9fc9bbd-2wmqf
X-Real-Ip: 10.244.137.64
```

## uninstall

```bash
kubectl delete -f https://ghproxy.com/https://raw.githubusercontent.com/dyrnq/dist/main/traefik/yaml/deploy.yaml
```
