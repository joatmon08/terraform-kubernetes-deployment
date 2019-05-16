# terraform-k8s

This repository contains examples for Terraform + Kubernetes with the [Terraform
Kubernetes
provider](https://www.terraform.io/docs/providers/kubernetes/index.html) and the
[Terraform Helm
provider](https://www.terraform.io/docs/providers/helm/index.html).

## Pre-Requisites

- Terraform Cloud Remote State Storage

  - See the [Getting
    Started](https://www.terraform.io/docs/enterprise/free/index.html) guide to
    set up an account.

- Terraform v0.12.0-beta2

  - While the latest Terraform v0.12.0 is a release candidate, Terraform Cloud
    remote state storage backend does not recognize `0.12.0-rc1` as a valid
    version. [Download 0.12.0-beta2
    here.](https://releases.hashicorp.com/terraform/0.12.0-beta2/) See [Github
    issue](https://github.com/hashicorp/terraform/issues/21306).

  - Initialize providers & modules.

    ```bash
    $ terraform init
    ```

- Kubernetes v1.14.1 cluster with 4CPU & 8GB of memory

  - Kubernetes on Docker for Desktop Stable will *not* work for zookeeper, as it
    runs v1.10.11. Docker for Desktop Edge may have other versions available.

  - If not using Docker for Desktop, [install
    Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) and run
    with the following command:

    ```bash
    $ minikube start --cpus 4 --memory 8192
    ```

- Helm v2.13.1

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

## Kubernetes Provider Notes

Below are features that are currently not covered by the Kubernetes provider:

- `beta` API not available. As a result, `PodDisruptionBudget` for the zookeeper
  example is omitted.

- No `podAffinity` or `podAntiAffinity` (Kubernetes 1.14 beta).

Observations:

- If creating modules for re-use and expecting a user to pass an arbitrary
  namespace, write a conditional to check for `default` or `kube-system` before
  creating the namespace. The provider behaves as the Kubernetes API would for
  namespaces.

- Use [k2tf Tool](https://github.com/sl1pm4t/k2tf) to translate Kubernetes YAML to
  Terraform (HCL). To convert HCL to HCL2, use `terraform 0.12upgrade`.

## Kubernetes Provider Notes

Below are features that are currently not covered by the Kubernetes provider:

- `beta` API not available. As a result, `PodDisruptionBudget` for the zookeeper
  example is omitted.

- No `podAffinity` or `podAntiAffinity` (Kubernetes 1.14 beta).

Other observations:

- If creating modules for re-use and expecting a user to pass an arbitrary
  namespace, write a conditional to check for `default` or `kube-system` before
  creating the namespace. The provider behaves as the Kubernetes API would for
  namespaces.

- [k2tf Tool](https://github.com/sl1pm4t/k2tf) to translate Kubernetes YAML to
  Terraform (HCL). To convert HCL to HCL2, use `terraform 0.12upgrade`.

## Helm Provider Notes

- Running a local chart does not require the `helm_repository` resource. The
  path to the chart is referenced within the `helm_release` resource. See this
  [closed
  issue](https://github.com/terraform-providers/terraform-provider-helm/issues/189)
  for additional context.