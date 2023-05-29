# Create a Network Security Group and allow access to port 22
az network nsg create --resource-group vmss-1 --name MyNsg
az network nsg rule create --resource-group vmss-1 --name AllowSsh --nsg-name MyNsg --priority 100 --destination-port-ranges 22

# Create a scale set
# Network resources such as an Azure load balancer are automatically created
az vmss create --resource-group vmss-1 --name myvmss --image CentOS --upgrade-policy-mode automatic --admin-username hangx --admin-password Convulse1234_ --nsg MyNsg