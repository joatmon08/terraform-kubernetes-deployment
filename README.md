# terraform-kubernetes-demo

This repository contains demos for Terraform + Kubernetes with the [Terraform
Kubernetes
provider](https://www.terraform.io/docs/providers/kubernetes/index.html).

## Pre-Requisites

- Terraform v0.12.0-rc1
- Kubernetes 1.10.11

## Usage

- `terraform plan`
- `terraform apply`

## Issues

- When updating the `selector` in Service after omitting it the first time,
  running `terraform apply` results in an error.

  ```sh
  Error: Failed to update service: jsonpatch replace operation does not apply: doc is missing key: /spec/selector

  on service.tf line 1, in resource "kubernetes_service" "example":
   1: resource "kubernetes_service" "example" {
  ```

- Using dynamic blocks for `container`. Need to follow-up to see how this is
  possible. It doesn't seem to pick up the attributes in the object.

- If I set variable to `null` as default for Kubernetes namespace, plan goes
  through because it knows to pass `default`. However, running `terraform apply`
  to create a custom namespace before running the module throws an error.

  ```shell
  Error: Namespace "" is invalid: metadata.name: Required value: name or generateName is required

  on main.tf line 5, in resource "kubernetes_namespace" "demo":
   5: resource "kubernetes_namespace" "demo" {
  ```

- Passing default namespace to `kubernetes_namespace` resources should not
  describe it as new. Maybe it needs to be `terraform import`? But Kubernetes
  API throws error.

  ```shell
  kubernetes_namespace.example: Creating...

  Error: namespaces "default" already exists
  ```

- `beta` API not available. As a result, `PodDisruptionBudget` for the zookeeper
  example is omitted.

- No `podAffinity` (GA) or `podAntiAffinity` (Kubernetes 1.14 beta).