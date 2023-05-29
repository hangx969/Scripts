# 实验目标
# 1个Root Module, 2个Child Module，创建一个resource group，一个storage account
# resource group的name作为output传给storage account做input variable
# storage account的name做为output传给我们

# This is Root Module
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.12.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# call "ResourceGroup" module which has 2 variables
module "ResourceGroup" { 
  source = "./ResourceGroup" # specify the location of child module
  basename = "learntfmodule" # the 1st variable
  location = "West US" # the 2nd variable
}

# call "StorageAccount" module which has 3 variables
module "StorageAccount" {
  source ="./StorageAccount" 
  basename = "learntfmodule"
  resource_group_name = module.ResourceGroup.rg_name_out #来自Resource Group module的outputs
  location = "West US"
}
