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
    version. 

  - Initialize providers & modules.

    ```bash
    $ terraform init
    ```

- Kubernetes v1.14.1

  - Kubernetes on Docker for Desktop Stable will *not* work for zookeeper, as it
    runs v1.10.11. Docker for Desktop Edge may have other versions available.

  - If not using Docker for Desktop, [install
    Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) and run
    with the following command:

    ```bash
    $ minikube start --cpus 4 --memory 8192
    ```

## Usage

The `main.tf` file references a:

- Nginx Deployment

- Zookeeper StatefulSet
  - Includes `provisioner` to run a quick acceptance test
  - Module in `zookeeper` directory

- Consul Helm chart
  - Includes `provisioner` to run `helm test`
  - Module in `helm-consul` directory

Run the commands below to deploy all examples to a Kubernetes cluster.

- `terraform plan -var-file=nginx.tfvars`
- `terraform apply -var-file=nginx.tfvars`

To clean up, run `terraform destroy -var-file=nginx.tfvars`.

## Kubernetes Provider Observations

Below are features that are currently not covered by the Kubernetes provider:

- `beta` API not available. As a result, `PodDisruptionBudget` for the zookeeper
  example is omitted.

- No `podAffinity` or `podAntiAffinity` (Kubernetes 1.14 beta).

Other observations:

- If creating modules for re-use and expecting a user to pass an arbitrary
  namespace, write a conditional to check for `default` or `kube-system` before
  creating the namespace. The provider behaves as the Kubernetes API would for
  namespaces.

- Forgot to include the `selector` for a Service. Ran `terraform apply` but the
  service was not properly created. Found the mistake and corrected it in the
  service. Ran `terraform apply` a second time and it resulted in the following
  error.

  ```bash
  Error: Failed to update service: jsonpatch replace operation does not apply: doc is missing key: /spec/selector

  on service.tf line 1, in resource "kubernetes_service" "deployment":
   1: resource "kubernetes_service" "deployment" {
  ```

- [k2tf Tool](https://github.com/sl1pm4t/k2tf) to translate Kubernetes YAML to
  Terraform (HCL). To convert HCL to HCL2, use `terraform 0.12upgrade`.

## Helm Provider Observations

- If Helm does not finish creating the resource and `terraform apply` is
  stopped, running `terraform destroy` will not purge the Helm release. Instead,
  it will orphan the release. Manually run `helm del --purge <release name>` in
  order to clean up all orphaned releases.

- Running a local chart does not require the `helm_repository` resource. The
  path to the chart is referenced within the `helm_release` resource. See this
  [closed
  issue](https://github.com/terraform-providers/terraform-provider-helm/issues/189)
  for additional context.

## Terraform v0.12 Observations

- Terraform v0.12: When using a for-each loop, it cannot find the attributes for
  the list of objects. The [Upgrading Terraform
  Guide](https://www.terraform.io/upgrade-guides/0-12.html) has the correct
  reference, requires `x.value.attribute`. [Terraform
  Expressions](https://www.terraform.io/docs/configuration/expressions.html) has
  an example but does not reflect why `.value` must be used before calling the
  `.attribute`.

- Generally, it seems that the last attribute in the series should have an `=`.
  The error message and guess-and-check covers what is not in documentation.