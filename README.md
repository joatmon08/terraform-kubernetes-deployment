# terraform-k8s

This repository contains examples for Terraform + Kubernetes with the [Terraform
Kubernetes
provider](https://www.terraform.io/docs/providers/kubernetes/index.html) and the
[Terraform Helm
provider](https://www.terraform.io/docs/providers/helm/index.html).

## Pre-Requisites

- Terraform Cloud Remote State Storage

  - [Sign up for an account](https://app.terraform.io/signup).

  - If this is to be used for a demo, ask the Community team for the demo login.
    Go to [the local-kubernetes
    workspace](https://app.terraform.io/app/hashicorp-team-demo/workspaces/dev/states).

- Terraform v0.12.0

  - Initialize providers & modules.

    ```shell
    $ terraform init
    ```

- Kubernetes v1.14.1 cluster with 4CPU & 8GB of memory

  - Kubernetes on Docker for Desktop Stable will *not* work for zookeeper, as it
    runs v1.10.11. Docker for Desktop Edge may have other versions available.

  - If not using Docker for Desktop, [install
    Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) and run
    with the following command:

    ```shell
    $ minikube start --cpus 4 --memory 8192
    ```

- Helm v2.14.0

  - [Download here.](https://github.com/helm/helm/releases)

  - Make sure tiller is running in the Kubernetes cluster.

    ```bash
    $ helm init
    ```

## Modules

The `main.tf` file references a:

- Nginx Deployment

- Zookeeper StatefulSet
  - Includes `provisioner` to run a quick acceptance test
  - Module in `zookeeper` directory
  - To enable, change variable `enable_module.zookeeper` to `true`.
    ```hcl
    enable_module = {
      zookeeper = true,
      helm_consul = false
    }
    ```

- Consul Helm chart
  - Includes `provisioner` to run `helm test`
  - Module in `helm-consul` directory
  - To enable, change variable `enable_module.helm_consul` to `1`
    ```hcl
    enable_module = {
      zookeeper = false,
      helm_consul = true
    }
    ```

## Usage

Run the commands below to deploy all examples to a Kubernetes cluster.

- `terraform plan -var-file=nginx.tfvars`
- `terraform apply -var-file=nginx.tfvars`

To clean up, run `terraform destroy -var-file=nginx.tfvars`.

## Recommended Demo Flow

1. This repository shows remote state management on Terraform Cloud. No need to
   provision buckets for remote state!

1. Open `main.tf` and show the `backend "remote"` configuration, which points to
   an organization and workspace in Terraform Cloud.

1. Open [Terraform
   Cloud](https://app.terraform.io/app/hashicorp-team-demo/workspaces) tab and
   show the workspaces. Any of the workspaces can be used to highlight state
   management.

1. Go through the repository and highlight some of the key features of Terraform
   v0.12.

   - First class expressions (no more variable interpolation)
   - Dynamic blocks (under `deployment.tf`, see the containers section)
   - Generalized splat (under `zookeeper/configmap.tf`)
   - For-loops in template syntax (under `zookeeper/configmap-hosts.tf`)

   For more information, show the [Terraform v0.12
   announcement](https://www.hashicorp.com/blog/announcing-terraform-0-12),
   which has more examples.

1. Ask if they would like to [sign up for Terraform
   Cloud](https://app.terraform.io/signup).

For a more complex example highlighting the differences between v0.11 vs. v0.12
and Terraform OSS vs. Terraform Cloud remote state, see [this example on Github](https://github.com/joatmon08/terraform0.12-cloud).