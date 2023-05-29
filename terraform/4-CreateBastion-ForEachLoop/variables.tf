variable "resourcegroup_name" {
  type        = string
  description = "The name of the resource group"
  default     = "BastionRG"
}

variable "location" {
  type        = string
  description = "The region for the deployment"
  default     = "West US"
}

variable "vnet_name" {
  type        = string
  description = "The name of the vnet"
  default     = "BastionVNET"
}

# 变量类型为list，是一list的值，这里只有一个值，还可以有更多
variable "vnet_address_space" {
  type        = list(any)
  description = "the address space of the VNet"
  default     = ["10.13.0.0/16"]
}

# 变量类型为map，是一list的kay value pairs
# 这里有多个instance，比如subnet_1是一个map，subnet_2又是一个map
variable "subnets" {
  type = map(any)
  default = {
    subnet_1 = {
      name             = "subnet_1"
      address_prefixes = ["10.13.1.0/24"] # []代表list，也就是一个或多个值
    }
    subnet_2 = {
      name             = "subnet_2"
      address_prefixes = ["10.13.2.0/24"]
    }
    subnet_3 = {
      name             = "subnet_3"
      address_prefixes = ["10.13.3.0/24"]
    }
    bastion_subnet = {
      name             = "AzureBastionSubnet" # Bastion的subnet必须是这个名
      address_prefixes = ["10.13.250.0/24"] # 必须/26或更大
    }
  }
}

variable "bastionhost_name" {
  type        = string
  description = "The name of the basion host"
  default     = "BastionHost"
}
