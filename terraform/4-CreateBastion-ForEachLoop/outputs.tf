# 提取subnet id，用于最后输出在屏幕上，并不用作任何input，可有可无
output "azure_subnet_id" {
    value = {
        for id in keys(var.subnets) : id => azurerm_subnet.subnet[id].id
    }
    description = "Lists the ID's of the subnets"
}

# 详解for表达式
# for表达式是将一种复杂类型映射成另一种复杂类型的表达式。输入类型值中的每一个元素都会被映射为一个或零个结果
# for语句中的：作为分割，左边是输入，右边是输出
# for语句被{}括住，代表了生成的是object，而=>就表示这个object的key:value的左右两边
# keys()是一个function，输入一个map，输出这个map的key，就比如我们中的subnet_1, subnet_2, subnet_3, bastion_subnet
# 经过这样一番遍历处理，最后的结果是生成了一个map
#azure_subnet_id {
#  subnet_1 : subnet_1的subnet id
#  subnet_2 : subnet_2的subnet id
#  subnet_3 : subnet_3的subnet id
#  bastion_subnet : bastion_subnet的subnet id
#}

# 提取bastion——pubip ，用于最后输出在屏幕上，并不用作任何input，可有可无
output "bastion_pubip" {
  value = azurerm_public_ip.bastion_pubip.ip_address
  description = "List the public IP of the bastion server"
}