# Set subscription
$subscriptionId ="f99c3d28-250e-4c4a-b0b6-92edb0849788"
Set-AzContext -SubscriptionId $subscriptionId

$resourceGroupName = "Monitor-Win"
$vmName = "Monitor-Win"

# Targeted VM
$vm = Get-AzVm -ResourceGroupName $resourceGroupName -Name $vmName

$disks = @()
[System.Collections.ArrayList]$disksList = $disks

# OS Disk
$disksList.Add($vm.properties.StorageProfile.OsDisk.Name)
# Data Disks
#$vm.StorageProfile.DataDisks.Name | foreach { $disksList.Add($_) }

