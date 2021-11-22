# tektoncd

## Installing Tekton Pipelines on Kubernetes

```bash
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
```

- <https://github.com/tektoncd/pipeline/blob/main/docs/install.md#installing-tekton-pipelines-on-kubernetes>

## Installing Tekton Triggers on Your Cluster

```bash
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml
```

- <https://github.com/tektoncd/triggers/blob/main/docs/install.md#installing-tekton-triggers-on-your-cluster>

## Installing Tekton Dashboard on Kubernetes

```bash
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
```

- <https://github.com/tektoncd/dashboard/blob/main/docs/install.md#installing-tekton-dashboard-on-kubernetes>

## ref

- <https://github.com/tektoncd/dashboard>
- <https://github.com/tektoncd/pipeline>
- <https://github.com/tektoncd/triggers>
