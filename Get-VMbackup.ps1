Connect-AzAccount -Environment AzureChinaCloud
Set-AzContext -Subscription f99c3d28-250e-4c4a-b0b6-92edb0849788

$resourceGroupName = "backup1"
$vmName = "b1"
$vaultName = "ASROnprem2A"

$vault = Get-AzRecoveryServicesVault -Name $vaultName
$Container = Get-AzRecoveryServicesBackupContainer -ContainerType AzureVM -VaultId $vault.ID
$backupitem = Get-AzRecoveryServicesBackupItem -VaultId $vault.ID -Name $vmName -Container $Container -WorkloadType AzureVM
$rp = Get-AzRecoveryServicesBackupRecoveryPoint -Item $backupitem -VaultId $vault.ID

$backupitem
$rp | Select-Object -Property RecoveryPointType, RecoveryPointTime, ContainerName, BackupManagementType