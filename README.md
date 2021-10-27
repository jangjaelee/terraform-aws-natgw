# AWS NAT Gateway Terraform module

Terraform module which creates NAT Gateway resources on AWS.

These types of resources are supported:

* [NAT Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)
* [EIP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)
* [Route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)


## Usage
### Create NAT Gateway

main.tf
```hcl
module "natgw" {
  source = "git@github.com:jangjaelee/terraform-aws-natgw.git"

  vpc_name = local.vpc_name
  natgw_name = local.vpc_name

  az_zone_names = ["ap-northeast-2a","ap-northeast-2c"]

  private_sub_env1 = "1"
  private_sub_env2 = "2"
  public_sub_env1  = "1"
  public_sub_env2  = "2"

  env = "dev"
}
```

locals.tf
```hcl
locals {
  vpc_name = "KubeSphere-dev"
  cluster_name = "KubeSphere-v121-dev"
  cluster_version = "1.21"
}
```

providers.tf
```hcl
provider "aws" {
  version = ">= 3.2.0"
  region = var.region
  allowed_account_ids = var.account_id
  profile = "eks_service"
}
```

terraform.tf
```hcl
terraform {
  required_version = ">= 0.13.0"

  backend "s3" {
    bucket = "kubesphere-terraform-state-backend"
    key = "dev/natgw/terraform.tfstate"
    region = "ap-northeast-2"
    dynamodb_table = "kubesphere-terraform-state-locks"
    encrypt = true
  profile = "eks_service"
  }
}
```

variables.tf
```hcl
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-2"
}

variable "account_id" {
  description = "List of Allowed AWS account IDs"
  type        = list(string)
  default     = ["123456789012"]
}
```
