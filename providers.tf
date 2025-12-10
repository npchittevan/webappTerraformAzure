terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.55.0"
    }
  }
  cloud {
    organization = "npchitt"
    workspaces {
      name = "myworkspace"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}