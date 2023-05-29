# 3 Files
# main.tf – The main configuration file for resource deployment.
# variables.tf – The file for variables used for the deployment.
# terraform.tfvars – The variable definition file used to set the variables for the deployment.

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.12.0"
    }
  }
}

provider "azurerm" {
  features{}
}

# Local is a also a varibale, it's for repetitive use.
locals {
  tags = {
    owner = "Sid"
    usage = "LearnTerraform"
  }
}

#Create a Resource Group, note "resourcegroup" is a local name for Terraform only
resource "azurerm_resource_group" "resourcegroup" {
  name     = var.rsgname #call Variable
  location = var.location #call Variable
  tags = local.tags # #call Local
}

#Create a Storage Account
resource "azurerm_storage_account" "storageaccount" {
  name                     = var.stgactname
  resource_group_name      = azurerm_resource_group.resourcegroup.name
  location                 = azurerm_resource_group.resourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags = local.tags
  }

