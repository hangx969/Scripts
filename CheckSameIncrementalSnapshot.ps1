$resourceGroupName = "Monitor-Win"
$snapshots = Get-AzSnapshot -ResourceGroupName $resourceGroupName
$diskName = "Monitor-Win_OsDisk_1_4b72e7ad16e74c75a3b4314a2a30b5c9"
$yourDisk = Get-AzDisk -DiskName $diskName -ResourceGroupName $resourceGroupName

$incrementalSnapshots = New-Object System.Collections.ArrayList
foreach ($snapshot in $snapshots)
{

    if($snapshot.Incremental -and $snapshot.CreationData.SourceResourceId -eq $yourDisk.Id -and $snapshot.CreationData.SourceUniqueId -eq $yourDisk.UniqueId){

        $incrementalSnapshots.Add($snapshot)
    }
}

$incrementalSnapshots