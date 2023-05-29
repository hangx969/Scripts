# 虽然我们可以通过这种方式指定variable，terraform plan -var="stgactname=cirtest332244423" 
# 但很不方便，所以我们创建terraform.tfvars文件

location = "chinanorth2"
rsgname = "HangxTerraformRG"
stgactname = "hangxtfsa1"