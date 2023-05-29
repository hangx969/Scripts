# 以下三个variable，是为了指明已存在的VNET
variable "subname" {
  type = string
  description = "The name of the existing subnet"
}

variable "vnetname" {
  type = string
  description = "The name of the existing vnet"
}

variable "vnetrg" {
  type = string
  description = "The name of the VNet Resource Group"
}

# 会被传到WinServer Module
variable "adminpw" {
  type = string
  sensitive = true 
  description = "the local admin password, must be 12 char or longer"
}