
# k8s-provision
Wellcome to Jeitto K8S provision Repo

This repo aims to provision Production and development kubernetes clusters.

# Requirements
- Unix System
- Terraform > v11
- jq
- python3
- kubectl
- istioctl
- GCP service account key

## Setting Up GCP Service Account Key
Ask the System Administrator for the service account key and place it at
/scripts/terraform/account.json

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

## Acessing Dashboards
Istioctl dashboard <dashboard-name>

names:
- grafana
- prometheus
- jaeger

#### Known Issues:
google: could not find default credentials

solution:
```
gcloud auth application-default login
```

