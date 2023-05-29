# Config login environment
Connect-AzAccount -Environment AzureChinaCloud
$subscriptionId ="f99c3d28-250e-4c4a-b0b6-92edb0849788"
Set-AzContext -Subscription $subscriptionId

# Set variables
$diskName = "dt1"
$resourceGroupName = "Monitor-Win"
$curDateTime = Get-Date -Format yyyyMMdd
$snapshotName = "Snapshot-" + $diskName + "-" + $curDateTime

# Get the disk that you need to backup by creating an incremental snapshot
$yourDisk = Get-AzDisk -DiskName $diskName -ResourceGroupName $resourceGroupName

# Create an incremental snapshot by setting the SourceUri property with the value of the Id property of the disk
$snapshotConfig=New-AzSnapshotConfig -SourceUri $yourDisk.Id -Location $yourDisk.Location -CreateOption Copy -Incremental 
New-AzSnapshot -ResourceGroupName $resourceGroupName -SnapshotName $snapshotName -Snapshot $snapshotConfig



# Copy snapshot to another Region

$sourceSnapshotName = $snapshotName
$targetRegion = "chinanorth2"
$targetSnapshotName = “Backup-” + $snapshotName


# Get source snapshot
$sourceSnapshot=Get-AzSnapshot -ResourceGroupName $resourceGroupName -SnapshotName $sourceSnapshotName

# Create new snapshot in target region
$snapshotconfig = New-AzSnapshotConfig -Location $targetRegion -CreateOption CopyStart -Incremental -SourceResourceId $sourceSnapshot.Id
New-AzSnapshot -ResourceGroupName $resourceGroupName -SnapshotName $targetSnapshotName -Snapshot $snapshotconfig

# Show information
$targetSnapshot=Get-AzSnapshot -ResourceGroupName $resourceGroupName -SnapshotName $targetSnapshotName


#Delete oroginal source snapshot
#Remove-AzSnapshot -ResourceGroupName $resourceGroupName -SnapshotName $sourceSnapshotName -Force;
