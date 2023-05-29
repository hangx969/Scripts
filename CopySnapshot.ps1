# Copy snapshot to another Region
$subscriptionId="f99c3d28-250e-4c4a-b0b6-92edb0849788"
$resourceGroupName = "Monitor-Win"
$sourceSnapshotName= ”Snapshot-Monitor-Win_OsDisk_1_4b72e7ad16e74c75a3b4314a2a30b5c9-20221121“
$targetRegion= "chinanorth2"
$targetSnapshotName= “Backup-” + $snapshotName

Set-AzContext -Subscription $subscriptionId

# Get source snapshot
$sourceSnapshot=Get-AzSnapshot -ResourceGroupName $resourceGroupName -SnapshotName $sourceSnapshotName

# Copy new snapshot in target region
$snapshotconfig = New-AzSnapshotConfig -Location $targetRegion -CreateOption CopyStart -Incremental -SourceResourceId $sourceSnapshot.Id
New-AzSnapshot -ResourceGroupName $resourceGroupName -SnapshotName $targetSnapshotName -Snapshot $snapshotconfig

# Show information
$targetSnapshot=Get-AzSnapshot -ResourceGroupName $resourceGroupName -SnapshotName $targetSnapshotName

$targetSnapshot.CompletionPercent