# Open Tofu POC

🐡 OpenTofu is an open-source fork of Terraform, created by the community after Terraform's license changed;

### Use Cases

✅ Provision infrastructure as code
✅ Use declarative configuration (.tf files)
✅ Supports providers like AWS, Kubernetes, Helm, Docker, etc.
✅ Is 100% Terraform-compatible (at v1.6+)

### How OpenTofu Works

⚙️ You write .tf (HCL) config files, then run OpenTofu CLI commands to:

| Command        | What It Does                                   |
| -------------- | ---------------------------------------------- |
| `tofu init`    | Initializes your project (downloads providers) |
| `tofu plan`    | Shows a preview of changes                     |
| `tofu apply`   | Applies the infrastructure                     |
| `tofu destroy` | Tears down infrastructure                      |


### Install (linux)

* https://opentofu.org/docs/intro/install/deb/#installing-using-the-installer


### Project Strucuture 

```
my-project/
├── main.tf
├── variables.tf
├── outputs.tf
└── tofu.lock.hcl
```

### Run

```
kubectl config use-context minikube # Switch context to minikube
tofu init                           # Sets up providers
tofu plan                           # Previews what will be created
tofu apply                          # Deploys infrastructure
```

```
kubernetes_namespace.opentofu_poc: Creating...
kubernetes_namespace.opentofu_poc: Creation complete after 0s [id=opentofu-poc]
helm_release.nginx: Creating...
helm_release.nginx: Still creating... [10s elapsed]
helm_release.nginx: Still creating... [20s elapsed]
helm_release.nginx: Still creating... [30s elapsed]
helm_release.nginx: Still creating... [40s elapsed]
helm_release.nginx: Creation complete after 41s [id=nginx]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

### Access server

* List pods
```bash
kubectl get pods -A
```

* Find node port

```bash
kubectl get svc nginx -n opentofu-poc
```

* Open server

```bash
minikube service nginx -n opentofu-poc
```

### Destroy 

```
tofu destroy    # Deletes infrastructure
```