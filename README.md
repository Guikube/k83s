# k8sSecurityScanner

## Kind

### create a cluster

```bash
#> create
kind create cluster --config=environment/kind.yaml

#> delete
kind delete cluster
```

### proxy api-server

````bash
kubectl proxy # default to 8001
````

### load image to kind

```
kind load docker-image local-image:test
```

