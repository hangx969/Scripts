terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.12.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

# 创建资源组
resource "azurerm_resource_group" "resouce_group" {
  name     = var.resource_group_name
  location = var.location
}

# 创建NSG
resource "azurerm_network_security_group" "network_security_group" {
  name                = var.name
  location            = var.location
  resource_group_name = azurerm_resource_group.resouce_group.name # 使得NSG的创建，需要在创建资源组之后

  dynamic "security_rule" {  # 这是一个dynamic group
    for_each = var.nsg_rules # 遍历var.nsg_rules这个list里面的每一项
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }
}
