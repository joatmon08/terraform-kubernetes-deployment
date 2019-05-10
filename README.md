# terraform-kubernetes-demo

This repository contains demos for Terraform + Kubernetes with the [Terraform
Kubernetes
provider](https://www.terraform.io/docs/providers/kubernetes/index.html).

## Pre-Requisites

- Terraform v0.12.0-rc1
- Kubernetes 1.10.11

## Usage

The `main.tf` file references a minimal nginx deployment and zookeeper
statefulset. Run the commands below to deploy both to a Kubernetes cluster.

- `terraform plan`
- `terraform apply`

## Not on Feature List

Below are features that are currently not covered by the provider.

- `beta` API not available. As a result, `PodDisruptionBudget` for the zookeeper
  demo is omitted.

- No `podAffinity` or `podAntiAffinity` (Kubernetes 1.14 beta).

## Kubernetes Provider Observations

- Creating `default` namespace to `kubernetes_namespace` has typical Kubernetes
  API behavior, throwing an `already exists` error. If an individual passes
  `default`, they'd have to write conditional to only create the namespace if it
  is not `default` or `kube-system`.

- When updating the `selector` in Service after omitting it the first time,
  running `terraform apply` results in an error.

  ```sh
  Error: Failed to update service: jsonpatch replace operation does not apply: doc is missing key: /spec/selector

  on service.tf line 1, in resource "kubernetes_service" "demo":
   1: resource "kubernetes_service" "demo" {
  ```

- Is there a way to translate Kubernetes YAML or JSON to Terraform? Tried to use
  raw JSON as a Terraform file, does not conform to syntax.

## Terraform v0.12 Observations

- Terraform v0.12: When using a for-each loop, it cannot find the attributes for
  the list of objects. The [Upgrading Terraform
  Guide](https://www.terraform.io/upgrade-guides/0-12.html) has the correct
  reference, requires `x.value.attribute`. [Terraform
  Expressions](https://www.terraform.io/docs/configuration/expressions.html) has
  an example but does not reflect why `.value` must be used before calling the
  `.attribute`.

- Kubernetes Provider / Terraform 0.12? Generally, it seems that the last
  attribute in the series should have an `=`. The error message and
  guess-and-check covers what is not in documentation.