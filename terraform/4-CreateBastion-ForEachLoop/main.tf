terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.12.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 创建resource group资源
resource "azurerm_resource_group" "vnet_rg" {
  name     = var.resourcegroup_name
  location = var.location
}

# 创建vnet资源
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rg.name # 没有写var.resourcegroup_name
}

# 创建subnet资源
resource "azurerm_subnet" "subnet" {
  for_each = var.subnets # for each 变量subnets，我要遍历里面每一个instance，重复一次本段代码
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = each.value["name"] # 提取变量subnets中的一个instance，中的name这个key的value
  address_prefixes     = each.value["address_prefixes"] # 提取变量subnets中的一个instance，中的address_prefixes这个key的value
}

# 创建public ip资源, 用作Bastion Host
resource "azurerm_public_ip" "bastion_pubip" {
  name                = "${var.bastionhost_name}PubIP"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
  allocation_method   = "Static" # bastion需要
  sku                 = "Standard" # bastion需要
}

# 创建bastion资源，Terraform默认部署basic sku
resource "azurerm_bastion_host" "bastion" {
  name                = var.bastionhost_name
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rg.name

  ip_configuration {
    name                 = "bastion_config"
    subnet_id            = azurerm_subnet.subnet["bastion_subnet"].id # 共有4个不同的id，担我们要指定bastion subnet的id
    public_ip_address_id = azurerm_public_ip.bastion_pubip.id # 要的是id
  } 
}
