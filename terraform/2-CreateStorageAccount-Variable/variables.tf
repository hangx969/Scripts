# Variables can be in main.tf, but it's a mess, so we seperated it

variable "location" {
  type = string
  description = "Location for deployment"
  default = "West US"
}

variable "rsgname" {
  type = string
  description = "Resource Group Name"
  default = "TerraformRG"
}

variable "stgactname" {
  type = string
  description = "Storage Account Name" #Storage Account should be globally unique
}