# StorageAccount module which has 3 variable

# Create Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "${var.basename}20220706" 
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}