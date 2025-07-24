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


