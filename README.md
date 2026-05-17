# webappTerraformAzure

Terraform configuration for deploying an Azure web application environment using reusable modules.

## Project Overview

This project provisions an Azure infrastructure that includes:

- Resource Group
- Virtual Network with multiple subnets
- Public IPs and network interfaces
- Network Security Group with configurable inbound rules
- Linux virtual machines
- Azure Load Balancer with backend pool and health probe

## Architecture

The root module composes the following child modules:

- `modules/resourcegroup` - creates the Azure Resource Group
- `modules/vnet` - creates the virtual network, subnets, public IPs, NICs, and network security group
- `modules/virtualMachine` - creates Linux VMs and attaches them to NICs
- `modules/loadbalancer` - creates a public load balancer and backend pool for the VMs

## Prerequisites

- Terraform >= 1.1.0
- Azure CLI or other Azure authentication configured
- Azure subscription with permissions to create resource groups, networks, VMs, public IPs, and load balancers

## Azure Provider

This project uses the `hashicorp/azurerm` provider pinned to version `4.55.0`.

It also contains Terraform Cloud configuration:

- Organization: `npchitt`
- Workspace: `myworkspace`

If you are not using Terraform Cloud, remove or update the `cloud` block in `providers.tf`.

## Usage

1. Authenticate to Azure:

   ```powershell
   az login
   az account set --subscription "<your-subscription-id>"
   ```

2. Initialize Terraform:

   ```powershell
   terraform init
   ```

3. Validate configuration:

   ```powershell
   terraform validate
   ```

4. Preview the deployment:

   ```powershell
   terraform plan
   ```

5. Apply the deployment:

   ```powershell
   terraform apply
   ```

6. Destroy the deployment when no longer needed:

   ```powershell
   terraform destroy
   ```

## Variables

The configuration defines the following root variables in `variables.tf`:

- `resource_group_name` - name of the resource group
- `location` - Azure region for resources
- `appvnet_name` - virtual network name
- `address_space` - VNet address space
- `network_security_group_rules` - list of NSG rules with `priority` and `destination_port_range`
- `app_subnet_count` - number of subnets and associated network resources
- `app_vm_count` - number of VMs to create

The sample values are provided in `terraform.tfvars`.

## Important Notes

- The VM module currently uses a hardcoded `admin_username` and `admin_password`.
  This is insecure and should be replaced with secure credentials, SSH keys, or Azure-managed identity before production use.
- `modules/virtualMachine/cloudinit` provides cloud-init configuration for the Linux VMs.
- The load balancer is configured to use port `80` with a TCP probe.

## Directory Structure

```
./
  main.tf
  providers.tf
  variables.tf
  terraform.tfvars
  README.md
  modules/
    resourcegroup/
    vnet/
    virtualMachine/
      cloudinit
    loadbalancer/
```

## Customization

Update `terraform.tfvars` to change the deployment values. You can also override variables via CLI:

```powershell
terraform apply -var="location=East US" -var="app_vm_count=3"
```

## Cleanup

When finished, run:

```powershell
terraform destroy
```
