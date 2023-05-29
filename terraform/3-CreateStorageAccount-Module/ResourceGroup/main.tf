#ResourceGroup module，该module有2个必须variable

#resource模板在Terraform官网下
resource "azurerm_resource_group" "example" {
  name     = "${var.basename}RG" # 将base_name这个variable和RG合并起来
  location = var.location # 使用location这个variable
}