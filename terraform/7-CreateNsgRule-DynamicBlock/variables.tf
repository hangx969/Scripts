
variable "location" {
    type = string
    description = "The location for the NSG"
}

variable "resource_group_name" {
  type = string
  description = "The name of the Resouce Group"
}

variable "name" {
  type = string
  description = "Name of the Network Security Group"
}

variable "nsg_rules" { # 创建一个variable
  type = list(object({ # 这个variable的类型是list，其中每个object都需要有下面这些值
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "The values for each NSG rule "
} 


