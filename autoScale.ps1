# 定义VM数量上下限
#az monitor autoscale create --resource-group "vmss-1" --resource myvmss --resource-type Microsoft.Compute/virtualMachineScaleSets --name autoscale --min-count 2 --max-count 10 --count 2

# 自动增加规则
az monitor autoscale rule create --resource-group "vmss-1" --autoscale-name autoscale --condition "Percentage CPU > 75 avg 5m" --scale out 3

# 自动减少规则
az monitor autoscale rule create --resource-group "vmss-1" --autoscale-name autoscale --condition "Percentage CPU < 25 avg 5m" --scale in 1