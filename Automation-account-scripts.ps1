##==========Manage VMs=================
workflow ManageVMs
{
	Param(
    [string]$resourceGroup,
    [string[]]$VMs,
    [string]$action
)

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process

# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity -EnvironmentName AzureChinaCloud).context

# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext   

# Start or stop VMs in parallel
if($action -eq "Start")
    {
        ForEach -Parallel ($vm in $VMs)
        {
            Start-AzVM -Name $vm -ResourceGroupName $resourceGroup -DefaultProfile $AzureContext
        }
    }
elseif ($action -eq "Stop")
    {
        ForEach -Parallel ($vm in $VMs)
        {
            Stop-AzVM -Name $vm -ResourceGroupName $resourceGroup -DefaultProfile $AzureContext -Force
        }
    }
else {
	    Write-Output "`r`n Action not allowed. Please enter 'stop' or 'start'."
	}
}

## =======Manage multiple vms=======
workflow ManageMutiVMs
{
	Param(
    [string]$resourceGroup,
    [string[]]$VMs,
    [string]$action
)

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process

# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity -EnvironmentName AzureChinaCloud).context

# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext   

# Start or stop VMs in parallel
if($action -eq "Start")
    {
        ForEach -Parallel ($vm in $VMs)
        {
            Start-AzVM -Name $vm -ResourceGroupName $resourceGroup -DefaultProfile $AzureContext
        }
    }
elseif ($action -eq "Stop")
    {
        ForEach -Parallel ($vm in $VMs)
        {
            Stop-AzVM -Name $vm -ResourceGroupName $resourceGroup -DefaultProfile $AzureContext -Force
        }
    }
else {
	    Write-Output "`r`n Action not allowed. Please enter 'stop' or 'start'."
	}
}

#=======Start VM=======
workflow StartVM
{
	
Param(
    [string]$resourceGroup,
    [string]$VMName
)
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process

# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity -EnvironmentName AzureChinaCloud).context

# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext   

# Start VM
Start-AzVM -Name $VMName -ResourceGroupName $resourceGroup -DefaultProfile $AzureContext

}


#=======python test=======
#!/usr/bin/env python3
print("Hello world")

# =======SystemAssignedId-login=======
workflow SystemAssignedId-login
{

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process

# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity -EnvironmentName AzureChinaCloud).context

# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext   
}

#======test script1=======
workflow test1
{
Parallel {
     Write-Output "Parallel"
     Get-Date
     Start-Sleep -s 3
     Get-Date
}

Write-Output " `r`n"
Write-Output "Non-Parallel"
Get-Date
Start-Sleep -s 3
Get-Date
}

#======test script1=======

Workflow MyFirstRunbook-Workflow
{
Parallel {
     Write-Output "Parallel"
     Get-Date
     Start-Sleep -s 3
     Get-Date
 }
}

#==========test scripts3=======================
Param(
 [string]$resourceGroup,
 [string]$VMName,
 [string]$method,
 [string]$UAMI 
)

$automationAccount = "autoTest1"

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process | Out-Null

# Connect using a Managed Service Identity
try {
        $AzureContext = (Connect-AzAccount -Identity).context
    }
catch{
        Write-Output "There is no system-assigned user identity. Aborting."; 
        exit
    }

# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription `
    -DefaultProfile $AzureContext

if ($method -eq "SA")
    {
        Write-Output "Using system-assigned managed identity"
    }
elseif ($method -eq "UA")
    {
        Write-Output "Using user-assigned managed identity"

        # Connects using the Managed Service Identity of the named user-assigned managed identity
        $identity = Get-AzUserAssignedIdentity -ResourceGroupName $resourceGroup `
            -Name $UAMI -DefaultProfile $AzureContext

        # validates assignment only, not perms
        if ((Get-AzAutomationAccount -ResourceGroupName $resourceGroup `
                -Name $automationAccount `
                -DefaultProfile $AzureContext).Identity.UserAssignedIdentities.Values.PrincipalId.Contains($identity.PrincipalId))
            {
                $AzureContext = (Connect-AzAccount -Identity -AccountId $identity.ClientId).context

                # set and store context
                $AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext
            }
        else {
                Write-Output "Invalid or unassigned user-assigned managed identity"
                exit
            }
    }
else {
        Write-Output "Invalid method. Choose UA or SA."
        exit
     }

# Get current state of VM
$status = (Get-AzVM -ResourceGroupName $resourceGroup -Name $VMName `
    -Status -DefaultProfile $AzureContext).Statuses[1].Code

Write-Output "`r`n Beginning VM status: $status `r`n"

# Start or stop VM based on current state
if($status -eq "Powerstate/deallocated")
    {
        Start-AzVM -Name $VMName -ResourceGroupName $resourceGroup -DefaultProfile $AzureContext
    }
elseif ($status -eq "Powerstate/running")
    {
        Stop-AzVM -Name $VMName -ResourceGroupName $resourceGroup -DefaultProfile $AzureContext -Force
    }

# Get new state of VM
$status = (Get-AzVM -ResourceGroupName $resourceGroup -Name $VMName -Status `
    -DefaultProfile $AzureContext).Statuses[1].Code  

Write-Output "`r`n Ending VM status: $status `r`n `r`n"

Write-Output "Account ID of current context: " $AzureContext.Account.Id