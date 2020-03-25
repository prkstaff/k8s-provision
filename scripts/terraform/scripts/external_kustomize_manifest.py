import json
import subprocess


# Get Kustomize manifests
result = subprocess.run(["bash", "-c", "kubectl kustomize manifests/env/provision"], stdout=subprocess.PIPE)

data_obj ={
    "data": result.stdout.decode("utf-8")
}
print(json.dumps(data_obj))
