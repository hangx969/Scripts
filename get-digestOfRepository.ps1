#azure container registry name
$registry_name="xhacrtest"
 
$repository_list=$(az acr repository list --name $registry_name --output tsv | ForEach-Object { $_ -replace "`n", " " })
 
foreach ($repository_name in $repository_list.Split(" ")) {
  Write-Host "Repository: $repository_name"
  az acr repository show-manifests --name $registry_name --repository $repository_name --query "[].{digest:digest, tags:tags}" --output table
}
