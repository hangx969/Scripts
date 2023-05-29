# create New disk object
$diskConfig = New-AzDiskConfig -Location "chinanorth3" -CreateOption "Empty" -DiskSizeGB 30 -SkuName "Standard_LRS"

# create New data disk
$dataDisk = New-AzDisk -ResourceGroupName "hangx-1" -DiskName "day1disk" -Disk $diskConfig

# Check if the disk is successfully created
Get-AzDisk -ResourceGroupName "hangx-1" -DiskName "day1disk"