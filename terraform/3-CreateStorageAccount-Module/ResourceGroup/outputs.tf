# output "Resource Group" name, to be used as an input variable for "Storage Account"

output "rg_name_out" {
  value = azurerm_resource_group.example.name # 资源类型.资源名.name
}