
# k8s-provision
Wellcome to Jeitto K8S provision Repo

This repo aims to provision Production and development kubernetes clusters.

# Requirements
- Unix System
- Terraform > v11
- jq
- python3

## Setting up environments

### Production

#### Provision

```bash
./run.sh provision --env prod
```

### Dev
```bash
./run.sh provision --env dev
```

#### Destroy Provision

```bash
./run.sh destroy --env prod
```

### Dev
```bash
./run.sh destroy --env dev
```


#### Known Issues:
google: could not find default credentials

solution:
```
gcloud auth application-default login
```

