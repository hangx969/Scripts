terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.12.0"
    }
  }
}

# 全部feature参阅 https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/features-block
provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion    = true #启用VM上的feature，当我们terraform destory时候，也删掉OS Disk一起删
      skip_shutdown_and_force_delete = true #启用VM上的feature，删VM时不需要验证机器已关
    } 
  }
}

# 创建resource group
resource "azurerm_resource_group" "resourcegroup" {
  name     = "TFTestRG01"
  location = "CentralUS"
}

# 使用data source，获取已存在的vnet信息
# 使用方法 https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet
data "azurerm_subnet" "vmsubnet" {
  name                 = var.subname
  virtual_network_name = var.vnetname
  resource_group_name  = var.vnetrg
}

# 获取到了VNET信息后，才能创建VM
module "vm" {
  source     = "./WinServer"
  rgname     = azurerm_resource_group.resourcegroup.name
  location   = azurerm_resource_group.resourcegroup.location
  vmname     = "TFTestServer"
  size       = "Standard_B2ms"
  localadmin = "locadmin"
  adminpw    = var.adminpw
  subnetid   = data.azurerm_subnet.vmsubnet.id # 从data source中获取到的
}
