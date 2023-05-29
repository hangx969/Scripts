# Config login environment
Connect-AzAccount -Environment AzureChinaCloud

# Set variables
$diskName = "Monitor-Win_OsDisk_1_4b72e7ad16e74c75a3b4314a2a30b5c9"


$curDateTime = Get-Date -Format yyyyMMdd
$snapshotName = "Snapshot-" + $diskName + "-" + $curDateTime

# Get the disk that you need to backup by creating an incremental snapshot
$yourDisk = Get-AzDisk -DiskName $diskName -ResourceGroupName $resourceGroupName

# Create an incremental snapshot by setting the SourceUri property with the value of the Id property of the disk
$snapshotConfig=New-AzSnapshotConfig -SourceUri $yourDisk.Id -Location $yourDisk.Location -CreateOption Copy -Incremental 
New-AzSnapshot -ResourceGroupName $resourceGroupName -SnapshotName $snapshotName -Snapshot $snapshotConfig






