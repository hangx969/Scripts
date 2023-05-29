# backend state需要在azurerm provider这加进去
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.12.0"
    }
  }
  backend "azurerm" { # 在这里添加backend state代码
    resource_group_name = "tfstateRG01"
    storage_account_name = "tfstate011000936712"
    container_name = "tfstate"
    key = "terraform.tfstate" # 指的是.tfstate文件名，不是指storage account access key
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resourcegroup" {
  name     = var.rsgname
  location = var.location
}


